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
        MASViewConstraint *newConstraint = constraint.equal(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.ex_equal(NSLayoutRelationEqual);
    });
    
    it(@"should start new constraint when encountering equal subsequently", ^{
        constraint.greaterThanOrEqual(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.equal(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering greaterThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqual(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.ex_equal(NSLayoutRelationGreaterThanOrEqual);
    });
    
    it(@"should start new constraint when encountering greaterThanOrEqual subsequently", ^{
        constraint.lessThanOrEqual(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.greaterThanOrEqual(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should return same constraint when encountering lessThanOrEqual for first time", ^{
        MASViewConstraint *newConstraint = constraint.lessThanOrEqual(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        expect(newConstraint).to.beIdenticalTo(constraint);
        expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
        expect(constraint.layoutRelation).to.ex_equal(NSLayoutRelationLessThanOrEqual);
    });
    
    it(@"should start new constraint when encountering lessThanOrEqual subsequently", ^{
        constraint.equal(secondViewAttribute);
        MASViewConstraint *newConstraint = constraint.lessThanOrEqual(secondViewAttribute);
        
        [verify(delegate) addConstraint:(id)constraint];
        [verify(delegate) addConstraint:(id)newConstraint];
        expect(newConstraint).notTo.beIdenticalTo(constraint);
    });
    
    it(@"should not allow update of equal once layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.equal(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of lessThanOrEqual once layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.lessThanOrEqual(secondViewAttribute);
        }).to.raise(@"NSInternalInconsistencyException");
    });
    
    it(@"should not allow update of greaterThanOrEqual once layoutconstraint is created", ^{
        [constraint commit];
        
        expect(^{
            constraint.greaterThanOrEqual(secondViewAttribute);
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
        
        expect(constraint.layoutConstant).to.ex_equal(10);
        expect(constraint.layoutConstraint.constant).to.ex_equal(10);
    });
    
    xit(@"should update sides only", ^{});
    
    xit(@"should update center only", ^{});
    
    xit(@"should update size only", ^{});
});

describe(@"commit", ^{
    
    it(@"should create layout constraint", ^{
        constraint.equal(secondViewAttribute);
        constraint.percent(0.5);
        constraint.offset(10);
        constraint.priority(345);
        [constraint commit];
        
        expect(constraint.layoutConstraint.firstAttribute).to.ex_equal(NSLayoutAttributeWidth);
        expect(constraint.layoutConstraint.secondAttribute).to.ex_equal(NSLayoutAttributeHeight);
        expect(constraint.layoutConstraint.firstItem).to.beIdenticalTo(constraint.firstViewAttribute.view);
        expect(constraint.layoutConstraint.secondItem).to.beIdenticalTo(constraint.secondViewAttribute.view);
        expect(constraint.layoutConstraint.relation).to.ex_equal(NSLayoutRelationEqual);
        expect(constraint.layoutConstraint.constant).to.ex_equal(10);
        expect(constraint.layoutConstraint.priority).to.ex_equal(345);
        expect(constraint.layoutConstraint.multiplier).to.ex_equal(0.5);
        
        [verify(superview) addConstraint:constraint.layoutConstraint];
    });
    
});

SpecEnd