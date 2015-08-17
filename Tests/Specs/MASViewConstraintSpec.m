//
//  MASViewConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASConstraint+Private.h"
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

SpecBegin(MASViewConstraint) {
    MASConstraintDelegateMock *delegate;
    MAS_VIEW *superview;
    MASViewConstraint *constraint;
    MAS_VIEW *otherView;
}

- (void)setUp {
    superview = MAS_VIEW.new;
    delegate = MASConstraintDelegateMock.new;

    MAS_VIEW *view = MAS_VIEW.new;
    constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width];
    constraint.delegate = delegate;

    [superview addSubview:view];

    otherView = MAS_VIEW.new;
    [superview addSubview:otherView];
}


- (void)testRelationCreateEqualConstraint {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    MASViewConstraint *newConstraint = (id)constraint.equalTo(secondViewAttribute);

    expect(newConstraint).to.beIdenticalTo(constraint);
    expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
    expect(constraint.layoutRelation).to.equal(NSLayoutRelationEqual);
}

- (void)testRelationCreateGreaterThanOrEqualConstraint {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    MASViewConstraint *newConstraint = (id)constraint.greaterThanOrEqualTo(secondViewAttribute);

    expect(newConstraint).to.beIdenticalTo(constraint);
    expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
    expect(constraint.layoutRelation).to.equal(NSLayoutRelationGreaterThanOrEqual);
}

- (void)testRelationCreateLessThanOrEqualConstraint {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    MASViewConstraint *newConstraint = (id)constraint.lessThanOrEqualTo(secondViewAttribute);

    expect(newConstraint).to.beIdenticalTo(constraint);
    expect(constraint.secondViewAttribute).to.beIdenticalTo(secondViewAttribute);
    expect(constraint.layoutRelation).to.equal(NSLayoutRelationLessThanOrEqual);
}

- (void)testRelationNotAllowUpdateOfEqual {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    constraint.lessThanOrEqualTo(secondViewAttribute);

    expect(^{
        constraint.equalTo(secondViewAttribute);
    }).to.raise(@"NSInternalInconsistencyException");
}

- (void)testRelationNotAllowUpdateOfLessThanOrEqual{
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    constraint.equalTo(secondViewAttribute);

    expect(^{
        constraint.lessThanOrEqualTo(secondViewAttribute);
    }).to.raise(@"NSInternalInconsistencyException");
}

- (void)testRelationNotAllowUpdateOfGreaterThanOrEqual {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    constraint.greaterThanOrEqualTo(secondViewAttribute);

    expect(^{
        constraint.greaterThanOrEqualTo(secondViewAttribute);
    }).to.raise(@"NSInternalInconsistencyException");
}


- (void)testRelationAcceptsView {
    MAS_VIEW *view = MAS_VIEW.new;
    constraint.equalTo(view);

    expect(constraint.secondViewAttribute.view).to.beIdenticalTo(view);
    expect(constraint.firstViewAttribute.layoutAttribute).to.equal(constraint.secondViewAttribute.layoutAttribute);
}

- (void)testRelationAcceptsNumber {
    constraint.equalTo(@42);
    
    expect(constraint.secondViewAttribute.view).to.beNil();
    expect(constraint.layoutConstant).to.equal(42);
}

- (void)testRelationAcceptsValueWithCGPoint {
    CGPoint point = CGPointMake(10, 20);
    NSValue *value = [NSValue value:&point withObjCType:@encode(CGPoint)];
    
    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.equalTo(value);
    expect(centerX.layoutConstant).to.equal(10);
    
    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.equalTo(value);
    expect(centerY.layoutConstant).to.equal(20);
    
    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.equalTo(value);
    expect(width.layoutConstant).to.equal(0);
}

- (void)testRelationAcceptsValueWithCGSize {
    CGSize size = CGSizeMake(30, 40);
    NSValue *value = [NSValue value:&size withObjCType:@encode(CGSize)];
    
    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.equalTo(value);
    expect(width.layoutConstant).to.equal(30);

    MASViewConstraint *height = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_height];
    height.equalTo(value);
    expect(height.layoutConstant).to.equal(40);
    
    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.equalTo(value);
    expect(centerX.layoutConstant).to.equal(0);
}

- (void)testRelationAcceptsValueWithEdgeInsets {
    MASEdgeInsets insets = (MASEdgeInsets){10, 20, 30, 40};
    NSValue *value = [NSValue value:&insets withObjCType:@encode(MASEdgeInsets)];
    
    MASViewConstraint *top = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_top];
    top.equalTo(value);
    expect(top.layoutConstant).to.equal(10);
    
    MASViewConstraint *left = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_left];
    left.equalTo(value);
    expect(left.layoutConstant).to.equal(20);

    MASViewConstraint *leading = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_leading];
    leading.equalTo(value);
    expect(leading.layoutConstant).to.equal(20);

    MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
    bottom.equalTo(value);
    expect(bottom.layoutConstant).to.equal(-30);

    MASViewConstraint *right = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_right];
    right.equalTo(value);
    expect(right.layoutConstant).to.equal(-40);

    MASViewConstraint *trailing = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_trailing];
    trailing.equalTo(value);
    expect(trailing.layoutConstant).to.equal(-40);
    
    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.equalTo(value);
    expect(centerX.layoutConstant).to.equal(0);
}


- (void)testRelationCreatesCompositeWithArrayOfViews {
    NSArray *views = @[MAS_VIEW.new, MAS_VIEW.new, MAS_VIEW.new];
    [delegate.constraints addObject:constraint];

    MASCompositeConstraint *composite = (id)constraint.equalTo(views).priorityMedium().offset(-10);

    expect(delegate.constraints).to.haveCountOf(1);
    expect(delegate.constraints[0]).to.beKindOf(MASCompositeConstraint.class);
    for (MASViewConstraint *childConstraint in composite.childConstraints) {
        NSUInteger index = [composite.childConstraints indexOfObject:childConstraint];
        expect(childConstraint.secondViewAttribute.view).to.beIdenticalTo((MAS_VIEW *)views[index]);
        expect(childConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
        expect(childConstraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
        expect(childConstraint.layoutPriority).to.equal(MASLayoutPriorityDefaultMedium);
        expect(childConstraint.layoutConstant).to.equal(-10);
    }
}

- (void)testRelationCreatesCompositeWithArrayOfAttributes {
    NSArray *viewAttributes = @[MAS_VIEW.new.mas_height, MAS_VIEW.new.mas_left];
    [delegate.constraints addObject:constraint];

    MASCompositeConstraint *composite = (id)constraint.equalTo(viewAttributes).priority(60).offset(10);

    expect(delegate.constraints).to.haveCountOf(1);
    expect(delegate.constraints[0]).to.beKindOf(MASCompositeConstraint.class);
    for (MASViewConstraint *childConstraint in composite.childConstraints) {
        NSUInteger index = [composite.childConstraints indexOfObject:childConstraint];
        expect(childConstraint.secondViewAttribute.view).to.beIdenticalTo([viewAttributes[index] view]);
        expect(childConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
        expect(childConstraint.secondViewAttribute.layoutAttribute).to.equal([viewAttributes[index] layoutAttribute]);
        expect(childConstraint.layoutPriority).to.equal(60);
        expect(childConstraint.layoutConstant).to.equal(10);
    }
}

- (void)testRelationComplainsWithUnsupportedArgument {
    expect(^{
        constraint.equalTo(@{});
    }).to.raise(@"NSInternalInconsistencyException");
}


- (void)testRelationAcceptsAutoboxedScalar {
    constraint.mas_equalTo(42);
    expect(constraint.layoutConstant).to.equal(42);
}

- (void)testRelationAcceptsAutoboxedCGPoint {
    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.mas_equalTo(CGPointMake(10, 20));
    expect(centerX.layoutConstant).to.equal(10);
    
    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.mas_equalTo(CGPointMake(10, 20));
    expect(centerY.layoutConstant).to.equal(20);
}

- (void)testRelationAcceptsAutoboxedCGSize {
    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.mas_equalTo(CGSizeMake(30, 40));
    expect(width.layoutConstant).to.equal(30);
    
    MASViewConstraint *height = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_height];
    height.mas_equalTo(CGSizeMake(30, 40));
    expect(height.layoutConstant).to.equal(40);
}

- (void)testRelationAcceptsAutoboxedEdgeInsets {
    MASEdgeInsets insets = (MASEdgeInsets){10, 20, 30, 40};
    
    MASViewConstraint *top = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_top];
    top.mas_equalTo(insets);
    expect(top.layoutConstant).to.equal(10);
    
    MASViewConstraint *left = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_left];
    left.mas_equalTo(insets);
    expect(left.layoutConstant).to.equal(20);
    
    MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
    bottom.mas_equalTo(insets);
    expect(bottom.layoutConstant).to.equal(-30);
    
    MASViewConstraint *right = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_right];
    right.mas_equalTo(insets);
    expect(right.layoutConstant).to.equal(-40);
}

- (void)testRelationAutoboxingComplainsWithUnsupportedArgument {
    expect(^{
        constraint.mas_equalTo(@{});
    }).to.raise(@"NSInternalInconsistencyException");
}


- (void)testPriorityHigh {
    constraint.equalTo(otherView);
    constraint.with.priorityHigh();
    [constraint install];

    expect(constraint.layoutPriority).to.equal(MASLayoutPriorityDefaultHigh);
    expect(constraint.layoutConstraint.priority).to.equal(MASLayoutPriorityDefaultHigh);
}


- (void)testPriorityLow {
    constraint.equalTo(otherView);
    constraint.with.priorityLow();
    [constraint install];

    expect(constraint.layoutPriority).to.equal(MASLayoutPriorityDefaultLow);
    expect(constraint.layoutConstraint.priority).to.equal(MASLayoutPriorityDefaultLow);
}


- (void)testPriorityMedium {
    constraint.equalTo(otherView);
    constraint.with.priorityMedium();
    [constraint install];

    expect(constraint.layoutPriority).to.equal(MASLayoutPriorityDefaultMedium);
    expect(constraint.layoutConstraint.priority).to.equal(MASLayoutPriorityDefaultMedium);
}


- (void)testMultiplierNotUpdate {
    [constraint install];

    expect(^{
        constraint.multipliedBy(0.9);
    }).to.raise(@"NSInternalInconsistencyException");
}


- (void)testMultiplierWithMultipliedBy {
    constraint.equalTo(otherView);
    constraint.multipliedBy(5);
    [constraint install];

    expect(constraint.layoutMultiplier).to.equal(5);
    expect(constraint.layoutConstraint.multiplier).to.equal(5);
}

- (void)testMultiplierWithDividedBy {
    constraint.equalTo(otherView);
    constraint.dividedBy(10);
    [constraint install];

    expect(constraint.layoutMultiplier).to.equal(0.1);
    expect(constraint.layoutConstraint.multiplier).to.beCloseTo(0.1);
}

- (void)testConstantUpdateAfterConstraintCreated {
    [constraint install];
    constraint.offset(10);

    expect(constraint.layoutConstant).to.equal(10);
    expect(constraint.layoutConstraint.constant).to.equal(10);
}


- (void)testConstantUpdateSidesOffset {
    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.with.insets((MASEdgeInsets){10, 10, 10, 10});
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
}

- (void)testConstantUpdateCenterOffsetOnly {
    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.centerOffset(CGPointMake(-20, -10));
    expect(width.layoutConstant).to.equal(0);

    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.centerOffset(CGPointMake(-20, -10));
    expect(centerX.layoutConstant).to.equal(-20);

    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.centerOffset(CGPointMake(-20, -10));
    expect(centerY.layoutConstant).to.equal(-10);
}

- (void)testConstantUpdateSizeOffsetOnly {
    MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
    bottom.sizeOffset(CGSizeMake(-40, 55));
    expect(bottom.layoutConstant).to.equal(0);

    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.sizeOffset(CGSizeMake(-40, 55));
    expect(width.layoutConstant).to.equal(-40);

    MASViewConstraint *height = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_height];
    height.sizeOffset(CGSizeMake(-40, 55));
    expect(height.layoutConstant).to.equal(55);
}


- (void)testAutoboxedConstantUpdateOffset {
    constraint.mas_offset(42);
    expect(constraint.layoutConstant).to.equal(42);
}

- (void)testAutoboxedConstantUpdateSidesOffset {
    MASEdgeInsets insets = (MASEdgeInsets){10, 20, 30, 40};
    
    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.mas_offset(insets);
    expect(centerY.layoutConstant).to.equal(0);
    
    MASViewConstraint *top = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_top];
    top.mas_offset(insets);
    expect(top.layoutConstant).to.equal(10);
    
    MASViewConstraint *left = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_left];
    left.mas_offset(insets);
    expect(left.layoutConstant).to.equal(20);
    
    MASViewConstraint *bottom = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_bottom];
    bottom.mas_offset(insets);
    expect(bottom.layoutConstant).to.equal(-30);
    
    MASViewConstraint *right = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_right];
    right.mas_offset(insets);
    expect(right.layoutConstant).to.equal(-40);
}

- (void)testAutoboxedConstantUpdateCenterOffset {
    MASViewConstraint *centerX = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerX];
    centerX.mas_offset(CGPointMake(-20, -10));
    expect(centerX.layoutConstant).to.equal(-20);
    
    MASViewConstraint *centerY = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_centerY];
    centerY.mas_offset(CGPointMake(-20, -10));
    expect(centerY.layoutConstant).to.equal(-10);
}

- (void)testAutoboxedConstantUpdateSizeOffset {
    MASViewConstraint *width = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_width];
    width.mas_offset(CGSizeMake(-40, 55));
    expect(width.layoutConstant).to.equal(-40);
    
    MASViewConstraint *height = [[MASViewConstraint alloc] initWithFirstViewAttribute:otherView.mas_height];
    height.mas_offset(CGSizeMake(-40, 55));
    expect(height.layoutConstant).to.equal(55);
}


- (void)testInstallLayoutConstraintOnCommit {
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

    expect(superview.constraints[0]).to.beIdenticalTo(constraint.layoutConstraint);
}


- (void)testInstallRelativeToSuperview {
    MAS_VIEW *view = MAS_VIEW.new;
    constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_baseline];
    constraint.delegate = delegate;
    [superview addSubview:view];

    constraint.equalTo(@10);
    [constraint install];

    expect(constraint.layoutConstraint.firstAttribute).to.equal(NSLayoutAttributeBaseline);
    expect(constraint.layoutConstraint.secondAttribute).to.equal(NSLayoutAttributeBaseline);
    expect(constraint.layoutConstraint.firstItem).to.beIdenticalTo(constraint.firstViewAttribute.view);
    expect(constraint.layoutConstraint.secondItem).to.beIdenticalTo(superview);
    expect(constraint.layoutConstraint.relation).to.equal(NSLayoutRelationEqual);
    expect(constraint.layoutConstraint.constant).to.equal(10);
    expect(superview.constraints[0]).to.beIdenticalTo(constraint.layoutConstraint);
}

- (void)testInstallWidthAsConstant {
    constraint.equalTo(@10);
    [constraint install];

    expect(constraint.layoutConstraint.firstAttribute).to.equal(NSLayoutAttributeWidth);
    expect(constraint.layoutConstraint.secondAttribute).to.equal(NSLayoutAttributeNotAnAttribute);
    expect(constraint.layoutConstraint.firstItem).to.beIdenticalTo(constraint.firstViewAttribute.view);
    expect(constraint.layoutConstraint.secondItem).to.beNil();
    expect(constraint.layoutConstraint.relation).to.equal(NSLayoutRelationEqual);
    expect(constraint.layoutConstraint.constant).to.equal(10);
    expect(constraint.firstViewAttribute.view.constraints[0]).to.beIdenticalTo(constraint.layoutConstraint);
}


- (void)testUninstallConstraint {
    MASViewAttribute *secondViewAttribute = otherView.mas_height;
    constraint.equalTo(secondViewAttribute);
    [constraint install];

    expect(superview.constraints).to.haveCountOf(1);
    expect(superview.constraints[0]).to.equal(constraint.layoutConstraint);

    [constraint uninstall];
    expect(superview.constraints).to.haveCountOf(0);
}

- (void)testAttributeChainingShouldNotHaveRelation {
    MASViewAttribute *secondViewAttribute = otherView.mas_top;
    constraint.lessThanOrEqualTo(secondViewAttribute);
    
    expect(^{
        __unused id result = constraint.bottom;
    }).to.raise(@"NSInternalInconsistencyException");
}

- (void)testAttributeChainingShouldCallDelegate {
    MASViewConstraint *result = (id)constraint.and.bottom;
    expect(result.firstViewAttribute.layoutAttribute).to.equal(@(NSLayoutAttributeBottom));
    expect(delegate.chainedConstraints).to.equal(@[constraint]);
}

SpecEnd