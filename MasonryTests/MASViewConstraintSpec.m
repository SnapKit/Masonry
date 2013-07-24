//
//  MASViewConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASConstraint.h"
#import "UIView+MASAdditions.h"

@interface MASViewConstraint ()

@property (nonatomic, strong) NSLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;

@end

SpecBegin(MASViewConstraint)

__block id<MASConstraintDelegate> delegate;
__block UIView *superview;
__block MASViewConstraint *constraint;
__block UIView *otherView;


beforeEach(^{
    superview = UIView.new;
    delegate = mockProtocol(@protocol(MASConstraintDelegate));

    UIView *view = UIView.new;
    constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width];
    constraint.delegate = delegate;

    [superview addSubview:view];

    otherView = UIView.new;
    [superview addSubview:otherView];
});

describe(@"equality chaining", ^{
    
    it(@"should return same constraint when encountering equal for first time", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationEqual);
    });
    
    it(@"should start new constraint when encountering equal subsequently", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.greaterThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering greaterThanOrEqual for first time", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationGreaterThanOrEqual);
    });
    
    it(@"should start new constraint when encountering greaterThanOrEqual subsequently", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.lessThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering lessThanOrEqual for first time", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationLessThanOrEqual);
    });
    
    it(@"should start new constraint when encountering lessThanOrEqual subsequently", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        constraint.equalTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should not allow update of equal once layoutconstraint is created", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        [constraint commit];
        
        expect(^{
            constraint.equalTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of lessThanOrEqual once layoutconstraint is created", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        [constraint commit];
        
        expect(^{
            constraint.lessThanOrEqualTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of greaterThanOrEqual once layoutconstraint is created", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_top;
        [constraint commit];
        
        expect(^{
            constraint.greaterThanOrEqualTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });

    it(@"should accept view object", ^{
        UIView *view = UIView.new;
        constraint.equalTo(view);

        expect(constraint.secondViewAttribute.view).to.beIdenticalTo(view);
        expect(constraint.firstViewAttribute.layoutAttribute).to.equal(constraint.secondViewAttribute.layoutAttribute);
    });
    
    xit(@"should create composite when passed array of views", ^{

    });
});

describe(@"multiplier & constant", ^{

    it(@"should not allow update of multiplier after layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.percent(0.9);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should allow update of constant after layoutconstraint is created", ^{
        [constraint commit];
        constraint.offset(10);
        
        expect(constraint.layoutConstant).to.equal(10);
        expect(constraint.layoutConstraint.constant).to.equal(10);
    });
    
    it(@"should update sides offset only", ^{
        MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
        centerY.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        expect(centerY.layoutConstant).to.equal(0);

        MASViewConstraint *top = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_top];
        top.insets(UIEdgeInsetsMake(15, 10, 10, 10));
        expect(top.layoutConstant).to.equal(15);

        MASViewConstraint *left = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_left];
        left.insets(UIEdgeInsetsMake(10, 15, 10, 10));
        expect(left.layoutConstant).to.equal(15);

        MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
        bottom.insets(UIEdgeInsetsMake(10, 10, 15, 10));
        expect(bottom.layoutConstant).to.equal(-15);

        MASViewConstraint *right = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_right];
        right.insets(UIEdgeInsetsMake(10, 10, 10, 15));
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

describe(@"commit", ^{

    it(@"should create layout constraint on commit", ^{
        MASViewAttribute *secondViewAttribute = otherView.mas_height;
        constraint.equalTo(secondViewAttribute);
        constraint.percent(0.5);
        constraint.offset(10);
        constraint.priority(345);
        [constraint commit];

        expect(constraint.layoutConstraint.firstAttribute).to.equal(NSLayoutAttributeWidth);
        expect(constraint.layoutConstraint.secondAttribute).to.equal(NSLayoutAttributeHeight);
        expect(constraint.layoutConstraint.firstItem).to.beIdenticalTo(constraint.firstViewAttribute.view);
        expect(constraint.layoutConstraint.secondItem).to.beIdenticalTo(constraint.secondViewAttribute.view);
        expect(constraint.layoutConstraint.relation).to.equal(NSLayoutRelationEqual);
        expect(constraint.layoutConstraint.constant).to.equal(10);
        expect(constraint.layoutConstraint.priority).to.equal(345);
        expect(constraint.layoutConstraint.multiplier).to.equal(0.5);

        expect(superview.constraints[0]).to.beIdenticalTo(constraint.layoutConstraint);
    });

});

SpecEnd