//
//  MASViewConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASConstraint.h"

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
__block id<MASConstraintDelegate> delegate;
__block MASViewAttribute *secondViewAttribute;

beforeEach(^{
    superview = mock(UIView.class);
    
    UIView *secondView = mock(UIView.class);
    [given(secondView.superview) willReturn:superview];
    secondViewAttribute = [[MASViewAttribute alloc] initWithView:secondView layoutAttribute:NSLayoutAttributeHeight];
    delegate = mockProtocol(@protocol(MASConstraintDelegate));
    
    UIView *firstView = mock(UIView.class);
    [given(firstView.superview) willReturn:superview];
    MASViewAttribute *firstViewAttribute = [[MASViewAttribute alloc] initWithView:firstView layoutAttribute:NSLayoutAttributeWidth];
    constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:firstViewAttribute];
    constraint.delegate = delegate;
});

describe(@"equality chaining", ^{
    
    it(@"should return same constraint when encountering equal for first time", ^{
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationEqual);
    });
    
    it(@"should start new constraint when encountering equal subsequently", ^{
        constraint.greaterThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.equalTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering greaterThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationGreaterThanOrEqual);
    });
    
    it(@"should start new constraint when encountering greaterThanOrEqual subsequently", ^{
        constraint.lessThanOrEqualTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqualTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering lessThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.equal(NSLayoutRelationLessThanOrEqual);
    });
    
    it(@"should start new constraint when encountering lessThanOrEqual subsequently", ^{
        constraint.equalTo(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.lessThanOrEqualTo(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
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
    
    xit(@"should update sides only", ^{});
    
    xit(@"should update center only", ^{});
    
    xit(@"should update size only", ^{});
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
        
        [verify(superview) addConstraint:constraint.layoutConstraint];
    });
    
});

SpecEnd