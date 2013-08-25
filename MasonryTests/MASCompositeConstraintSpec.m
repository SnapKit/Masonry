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
#import "View+MASAdditions.h"

@interface MASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@interface MASViewConstraint ()

@property (nonatomic, weak) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;

@end

SpecBegin(MASCompositeConstraint)

__block MASConstraintDelegateMock *delegate;
__block MAS_VIEW *superview;
__block MAS_VIEW *view;
__block MASCompositeConstraint *composite;

beforeEach(^{
    delegate = MASConstraintDelegateMock.new;
    view = MAS_VIEW.new;
    superview = MAS_VIEW.new;
    [superview addSubview:view];
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_height]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
});

it(@"should complete children", ^{
    MAS_VIEW *newView = MAS_VIEW.new;

    //first equality statement
    composite.equalTo(newView).sizeOffset(CGSizeMake(90, 30)).priorityLow();
    
    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = [composite.childConstraints objectAtIndex:0];
    expect(viewConstraint.secondViewAttribute.view).to.beIdenticalTo(newView);
    expect(viewConstraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
    expect(viewConstraint.layoutConstant).to.equal(90);
    expect(viewConstraint.layoutPriority).to.equal(MASLayoutPriorityDefaultLow);

    viewConstraint = [composite.childConstraints objectAtIndex:1];
    expect(viewConstraint.secondViewAttribute.view).to.beIdenticalTo(newView);
    expect(viewConstraint.secondViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeHeight);
    expect(viewConstraint.layoutConstant).to.equal(30);
    expect(viewConstraint.layoutPriority).to.equal(MASLayoutPriorityDefaultLow);
});

it(@"should not remove on install", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    [superview addSubview:newView];

    //first equality statement
    composite.equalTo(newView).sizeOffset(CGSizeMake(90, 30));

    [composite install];

    expect(composite.childConstraints).to.haveCountOf(2);
});

it(@"should spawn child composite constraints", ^{
    MAS_VIEW *otherView = MAS_VIEW.new;
    [superview addSubview:otherView];
    composite.lessThanOrEqualTo(@[@2, otherView]);

    expect(composite.childConstraints).to.haveCountOf(2);
    expect([composite.childConstraints objectAtIndex:0]).to.beKindOf(MASCompositeConstraint.class);
    expect([composite.childConstraints objectAtIndex:1]).to.beKindOf(MASCompositeConstraint.class);
});

SpecEnd