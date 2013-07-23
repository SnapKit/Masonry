//
//  MASViewConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASConstraint.h"
#import "SpecHelpers.h"

@interface MASViewConstraint ()

@property (nonatomic, strong) NSLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;

@end

SpecBegin(MASViewConstraint)

__block UIView *superview;
__block MASViewConstraint *constraint;
__block MASViewAttribute *secondViewAttribute;

beforeEach(^{
    superview = UIView.new;
    constraint = createConstraintWithLayoutAttribute(NSLayoutAttributeWidth);
    [superview addSubview:constraint.firstViewAttribute.view];

    secondViewAttribute = createViewAttribute(NSLayoutAttributeHeight);
    [superview addSubview:secondViewAttribute.view];
});

describe(@"equality chaining", ^{
    
    it(@"should return same constraint when encountering equal for first time", ^{
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationEqual);
    });
    
    it(@"should start new constraint when encountering equal subsequently", ^{
        constraint.greaterThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering greaterThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationGreaterThanOrEqual);
    });
    
    it(@"should start new constraint when encountering greaterThanOrEqual subsequently", ^{
        constraint.lessThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering lessThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationLessThanOrEqual);
    });
    
    it(@"should start new constraint when encountering lessThanOrEqual subsequently", ^{
        constraint.equalTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(constraint.delegate) addConstraint:(id)constraint];
        [verify(constraint.delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should not allow update of equal once layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.equalTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of lessThanOrEqual once layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.lessThanOrEqualTo(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of greaterThanOrEqual once layoutconstraint is created", ^{
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
        MASViewConstraint *centerY = createConstraintWithLayoutAttribute(NSLayoutAttributeCenterY);
        centerY.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        expect(centerY.layoutConstant).to.equal(0);

        MASViewConstraint *top = createConstraintWithLayoutAttribute(NSLayoutAttributeTop);
        top.insets(UIEdgeInsetsMake(15, 10, 10, 10));
        expect(top.layoutConstant).to.equal(15);

        MASViewConstraint *left = createConstraintWithLayoutAttribute(NSLayoutAttributeLeft);
        left.insets(UIEdgeInsetsMake(10, 15, 10, 10));
        expect(left.layoutConstant).to.equal(15);

        MASViewConstraint *bottom = createConstraintWithLayoutAttribute(NSLayoutAttributeBottom);
        bottom.insets(UIEdgeInsetsMake(10, 10, 15, 10));
        expect(bottom.layoutConstant).to.equal(-15);

        MASViewConstraint *right = createConstraintWithLayoutAttribute(NSLayoutAttributeRight);
        right.insets(UIEdgeInsetsMake(10, 10, 10, 15));
        expect(right.layoutConstant).to.equal(-15);
    });
    
    it(@"should update center offset only", ^{
        MASViewConstraint *width = createConstraintWithLayoutAttribute(NSLayoutAttributeWidth);
        width.centerOffset(CGPointMake(-20, -10));
        expect(width.layoutConstant).to.equal(0);

        MASViewConstraint *centerX = createConstraintWithLayoutAttribute(NSLayoutAttributeCenterX);
        centerX.centerOffset(CGPointMake(-20, -10));
        expect(centerX.layoutConstant).to.equal(-20);

        MASViewConstraint *centerY = createConstraintWithLayoutAttribute(NSLayoutAttributeCenterY);
        centerY.centerOffset(CGPointMake(-20, -10));
        expect(centerY.layoutConstant).to.equal(-10);
    });
    
    it(@"should update size offset only", ^{
        MASViewConstraint *bottom = createConstraintWithLayoutAttribute(NSLayoutAttributeBottom);
        bottom.sizeOffset(CGSizeMake(-40, 55));
        expect(bottom.layoutConstant).to.equal(0);

        MASViewConstraint *width = createConstraintWithLayoutAttribute(NSLayoutAttributeWidth);
        width.sizeOffset(CGSizeMake(-40, 55));
        expect(width.layoutConstant).to.equal(-40);

        MASViewConstraint *height = createConstraintWithLayoutAttribute(NSLayoutAttributeHeight);
        height.sizeOffset(CGSizeMake(-40, 55));
        expect(height.layoutConstant).to.equal(55);
    });
});

describe(@"commit", ^{
    
    it(@"should create layout constraint", ^{
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