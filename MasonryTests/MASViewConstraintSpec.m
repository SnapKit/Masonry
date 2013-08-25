//
//  MASViewConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASConstraint.h"
#import "View+MASAdditions.h"
#import "MASConstraintDelegateMock.h"
#import "MASCompositeConstraint.h"

@interface MASViewConstraint ()

@property (nonatomic, weak) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;

@end

@interface MASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

SpecBegin(MASViewConstraint)

__block MASConstraintDelegateMock *delegate;
__block MAS_VIEW *superview;
__block MASViewConstraint *constraint;
__block MAS_VIEW *otherView;


beforeEach(^{
    superview = MAS_VIEW.new;
    delegate = MASConstraintDelegateMock.new;

    MAS_VIEW *view = MAS_VIEW.new;
    constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width];
    constraint.delegate = delegate;

    [superview addSubview:view];

    otherView = MAS_VIEW.new;
    [superview addSubview:otherView];
});

describe(@"create equality constraint", ^{
    
    it(@"should create equal constraint", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = (id)constraint.equalTo(secondViewAttribute);
        
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationEqual);
    });
    
    it(@"should create greaterThanOrEqual constraint", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = (id)constraint.greaterThanOrEqualTo(secondViewAttribute);

        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationGreaterThanOrEqual);
    });
    
    it(@"create lessThanOrEqual constraint", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = (id)constraint.lessThanOrEqualTo(secondViewAttribute);

        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationLessThanOrEqual);
    });
    
    it(@"should not allow update of equal", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.lessThanOrEqualTo(secondViewAttribute);
        
        expect(^{
            constraint.equalTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of lessThanOrEqual", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.equalTo(secondViewAttribute);
        
        expect(^{
            constraint.lessThanOrEqualTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of greaterThanOrEqual", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        expect(^{
            constraint.greaterThanOrEqualTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });

    it(@"should accept view object", ^{
        MAS_VIEW *view = MAS_VIEW.new;
        constraint.equalTo(view);

        expect(constraint.secondViewAttribute.view).to.beIdenticalTo(view);
        expect(constraint.firstViewAttribute.layoutAttribute).to.equal(constraint.secondViewAttribute.layoutAttribute);
    });
    
    it(@"should create composite when passed array of views", ^{
        NSArray *views = @[MAS_VIEW.new, MAS_VIEW.new, MAS_VIEW.new];
        [delegate.constraints addObject:constraint];

        MASCompositeConstraint *composite = (id)constraint.equalTo(views).priorityMedium().offset(-10);

        expect(delegate.constraints).to.haveCountOf(1);
        expect([delegate.constraints objectAtIndex:0]).to.beKindOf(MASCompositeConstraint.class);
        for (MASViewConstraint *constraint in composite.childConstraints) {
            NSUInteger index = [composite.childConstraints indexOfObject:constraint];
            expect(constraint.secondViewAttribute.view).to.beIdenticalTo((MAS_VIEW *)[views objectAtIndex:index]);
            expect(constraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
            expect(constraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
            expect(constraint.layoutPriority).to.equal(MASLayoutPriorityDefaultMedium);
            expect(constraint.layoutConstant).to.equal(-10);
        }
    });

    it(@"should create composite when passed array of attributes", ^{
        NSArray *viewAttributes = @[MAS_VIEW.new.mas_height, MAS_VIEW.new.mas_left];
        [delegate.constraints addObject:constraint];
        
        MASCompositeConstraint *composite = (id)constraint.equalTo(viewAttributes).priority(60).offset(10);

        expect(delegate.constraints).to.haveCountOf(1);
        expect([delegate.constraints objectAtIndex:0]).to.beKindOf(MASCompositeConstraint.class);
        for (MASViewConstraint *constraint in composite.childConstraints) {
            NSUInteger index = [composite.childConstraints indexOfObject:constraint];
            expect(constraint.secondViewAttribute.view).to.beIdenticalTo([[viewAttributes objectAtIndex:index] view]);
            expect(constraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
            expect(constraint.secondViewAttribute.layoutAttribute).to.equal([[viewAttributes objectAtIndex:index] layoutAttribute]);
            expect(constraint.layoutPriority).to.equal(60);
            expect(constraint.layoutConstant).to.equal(10);
        }
    });
});

describe(@"multiplier & constant", ^{

    it(@"should not allow update of multiplier after layoutconstraint is created", ^{
        [constraint install];
        
        expect(^{
            constraint.multipliedBy(0.9);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should allow update of constant after layoutconstraint is created", ^{
        [constraint install];
        constraint.offset(10);
        
        expect(constraint.layoutConstant).to.equal(10);
        expect(constraint.layoutConstraint.constant).to.equal(10);
    });
    
    it(@"should update sides offset only", ^{
        MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
        centerY.insets((MASEdgeInsets){10, 10, 10, 10});
        expect(centerY.layoutConstant).to.equal(0);

        MASViewConstraint *top = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_top];
        top.insets((MASEdgeInsets){15, 10, 10, 10});
        expect(top.layoutConstant).to.equal(15);

        MASViewConstraint *left = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_left];
        left.insets((MASEdgeInsets){10, 15, 10, 10});
        expect(left.layoutConstant).to.equal(15);

        MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
        bottom.insets((MASEdgeInsets){10, 10, 15, 10});
        expect(bottom.layoutConstant).to.equal(-15);

        MASViewConstraint *right = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_right];
        right.insets((MASEdgeInsets){10, 10, 10, 15});
        expect(right.layoutConstant).to.equal(-15);
    });
    
    it(@"should update center offset only", ^{
        MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
        width.centerOffset(CGPointMake(-20, -10));
        expect(width.layoutConstant).to.equal(0);

        MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
        centerX.centerOffset(CGPointMake(-20, -10));
        expect(centerX.layoutConstant).to.equal(-20);

        MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
        centerY.centerOffset(CGPointMake(-20, -10));
        expect(centerY.layoutConstant).to.equal(-10);
    });
    
    it(@"should update size offset only", ^{
        MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
        bottom.sizeOffset(CGSizeMake(-40, 55));
        expect(bottom.layoutConstant).to.equal(0);

        MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
        width.sizeOffset(CGSizeMake(-40, 55));
        expect(width.layoutConstant).to.equal(-40);

        MASViewConstraint *height = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_height];
        height.sizeOffset(CGSizeMake(-40, 55));
        expect(height.layoutConstant).to.equal(55);
    });
});

describe(@"install", ^{

    it(@"should create layout constraint on commit", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_height;
        constraint.equalTo(secondViewAttribute);
        constraint.multipliedBy(0.5);
        constraint.offset(10);
        constraint.priority(345);
        [constraint install];

        expect(constraint.layoutConstraint.firstAttribute).to.equal(NSLayoutAttributeWidth);
        expect(constraint.layoutConstraint.secondAttribute).to.equal(NSLayoutAttributeHeight);
        expect(constraint.layoutConstraint.firstItem).to.beIdenticalTo(constraint.firstViewAttribute.view);
        expect(constraint.layoutConstraint.secondItem).to.beIdenticalTo(constraint.secondViewAttribute.view);
        expect(constraint.layoutConstraint.relation).to.equal(NSLayoutRelationEqual);
        expect(constraint.layoutConstraint.constant).to.equal(10);
        expect(constraint.layoutConstraint.priority).to.equal(345);
        expect(constraint.layoutConstraint.multiplier).to.equal(0.5);

        expect([superview.constraints objectAtIndex:0]).to.beIdenticalTo(constraint.layoutConstraint);
    });

    it(@"should uninstall constraint", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_height;
        constraint.equalTo(secondViewAttribute);
        [constraint install];

        expect(superview.constraints).to.haveCountOf(1);
        expect([superview.constraints objectAtIndex:0]).to.equal(constraint.layoutConstraint);

        [constraint uninstall];
        expect(superview.constraints).to.haveCountOf(0);
    });

});

SpecEnd