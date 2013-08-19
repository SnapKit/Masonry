//
//  MASCompositeConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASCompositeConstraint.h"
#import "MASViewConstraint.h"
#import "MASConstraintDelegateMock.h"

@interface MASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@interface MASViewConstraint ()

@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;

@end

SpecBegin(MASCompositeConstraint)

__block MASConstraintDelegateMock *delegate;
__block MAS_VIEW *superview;
__block MAS_VIEW *view;
__block MASCompositeConstraint *composite;

beforeEach(^{
    composite = nil;
    delegate = MASConstraintDelegateMock.new;
    view = MAS_VIEW.new;
    superview = MAS_VIEW.new;
    [superview addSubview:view];
});

it(@"should create centerY and centerX children", ^{
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeCenter];

    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = composite.childConstraints[0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeCenterX);

    viewConstraint = composite.childConstraints[1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeCenterY);
});

it(@"should create top, left, bottom, right children", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeEdges];
    composite.equalTo(newView);

    expect(composite.childConstraints).to.haveCountOf(4);

    //top
    MASViewConstraint *viewConstraint = composite.childConstraints[0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeTop);

    //left
    viewConstraint = composite.childConstraints[1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeLeft);

    //bottom
    viewConstraint = composite.childConstraints[2];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeBottom);

    //right
    viewConstraint = composite.childConstraints[3];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeRight);
});

it(@"should create width and height children", ^{
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeSize];
    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = composite.childConstraints[0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);

    viewConstraint = composite.childConstraints[1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(composite.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeHeight);
});

it(@"should complete children", ^{
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeSize];
    composite.delegate = delegate;
    MAS_VIEW *newView = MAS_VIEW.new;

    //first equality statement
    composite.equalTo(newView).sizeOffset(CGSizeMake(90, 30)).priorityLow();
    
    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = composite.childConstraints[0];
    expect(viewConstraint.secondViewAttribute.view).to.beIdenticalTo(newView);
    expect(viewConstraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
    expect(viewConstraint.layoutConstant).to.equal(90);
    expect(viewConstraint.layoutPriority).to.equal(MASLayoutPriorityDefaultLow);

    viewConstraint = composite.childConstraints[1];
    expect(viewConstraint.secondViewAttribute.view).to.beIdenticalTo(newView);
    expect(viewConstraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeHeight);
    expect(viewConstraint.layoutConstant).to.equal(30);
    expect(viewConstraint.layoutPriority).to.equal(MASLayoutPriorityDefaultLow);
});

it(@"should not remove on install", ^{
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeSize];
    composite.delegate = delegate;
    MAS_VIEW *newView = MAS_VIEW.new;
    [superview addSubview:newView];

    //first equality statement
    composite.equalTo(newView).sizeOffset(CGSizeMake(90, 30));

    [composite install];

    expect(composite.childConstraints).to.haveCountOf(2);
});

it(@"should spawn child composite constraints", ^{
    composite = [[MASCompositeConstraint alloc] initWithView:view type:MASCompositeConstraintTypeSize];
    composite.delegate = delegate;

    MAS_VIEW *otherView = MAS_VIEW.new;
    [superview addSubview:otherView];
    composite.lessThanOrEqualTo(@[@2, otherView]);

    expect(composite.childConstraints).to.haveCountOf(2);
    expect(composite.childConstraints[0]).to.beKindOf(MASCompositeConstraint.class);
    expect(composite.childConstraints[1]).to.beKindOf(MASCompositeConstraint.class);
});

SpecEnd