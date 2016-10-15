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
@property (nonatomic, assign) CGFloat layoutMultiplier;

@end

SpecBegin(MASCompositeConstraint) {
    MASConstraintDelegateMock *delegate;
    MAS_VIEW *superview;
    MAS_VIEW *view;
    MASCompositeConstraint *composite;
}

- (void)setUp {
    delegate = MASConstraintDelegateMock.new;
    view = MAS_VIEW.new;
    superview = MAS_VIEW.new;
    [superview addSubview:view];
}

- (void)testCompleteChildren {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_height]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    
    MAS_VIEW *newView = MAS_VIEW.new;

    //first equality statement
    composite.greaterThanOrEqualTo(newView).sizeOffset(CGSizeMake(90, 30)).multipliedBy(3).priorityLow();
    
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
}

- (void)testDoNotRemoveOnInstall {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_centerX],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_centerY]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    MAS_VIEW *newView = MAS_VIEW.new;
    [superview addSubview:newView];

    //first equality statement
    composite.equalTo(newView).centerOffset(CGPointMake(90, 30)).dividedBy(2).priorityHigh();
    [composite install];

    expect(composite.childConstraints).to.haveCountOf(2);
    
    MASViewConstraint *viewConstraint = composite.childConstraints[0];
    expect([viewConstraint layoutConstant]).to.equal(90);
    expect([viewConstraint layoutMultiplier]).to.equal(0.5);
    expect([viewConstraint layoutPriority]).to.equal(MASLayoutPriorityDefaultHigh);

    viewConstraint = composite.childConstraints[1];
    expect([viewConstraint layoutConstant]).to.equal(30);
    expect([viewConstraint layoutMultiplier]).to.equal(0.5);
    expect([viewConstraint layoutPriority]).to.equal(MASLayoutPriorityDefaultHigh);
}

- (void)testSpawnChildCompositeConstraints {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_height]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    MAS_VIEW *otherView = MAS_VIEW.new;
    [superview addSubview:otherView];
    composite.lessThanOrEqualTo(@[@2, otherView]);

    expect(composite.childConstraints).to.haveCountOf(2);
    expect(composite.childConstraints[0]).to.beKindOf(MASCompositeConstraint.class);
    expect(composite.childConstraints[1]).to.beKindOf(MASCompositeConstraint.class);
}

- (void)testModifyInsetsOnAppropriateChildren {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_right],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_top],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_bottom],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_left],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_baseline],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width],
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;

    composite.with.insets((MASEdgeInsets){1, 2, 3, 4});

    expect([children[0] layoutConstant]).to.equal(-4);
    expect([children[1] layoutConstant]).to.equal(1);
    expect([children[2] layoutConstant]).to.equal(-3);
    expect([children[3] layoutConstant]).to.equal(2);
    expect([children[4] layoutConstant]).to.equal(0);
    expect([children[5] layoutConstant]).to.equal(0);
};

- (void)testModifyInsetOnAppropriateChildren {
    NSArray *children = @[
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_right],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_top],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_bottom],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_left],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_baseline],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_width],
                          ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    
    composite.with.inset(1);
    
    expect([children[0] layoutConstant]).to.equal(-1);
    expect([children[1] layoutConstant]).to.equal(1);
    expect([children[2] layoutConstant]).to.equal(-1);
    expect([children[3] layoutConstant]).to.equal(1);
    expect([children[4] layoutConstant]).to.equal(0);
    expect([children[5] layoutConstant]).to.equal(0);
};

- (void)testUninstall {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_leading],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_trailing]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    MAS_VIEW *newView = MAS_VIEW.new;
    [superview addSubview:newView];

    //first equality statement
    composite.equalTo(newView);
    [composite install];

    expect(superview.constraints).to.haveCountOf(2);
    [composite uninstall];
    expect(superview.constraints).to.haveCountOf(0);
}

- (void)testActivateDeactivate {
    NSArray *children = @[
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_leading],
                          [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_trailing]
                          ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    MAS_VIEW *newView = MAS_VIEW.new;
    [superview addSubview:newView];
    
    //first equality statement
    composite.equalTo(newView);
    [composite install];
    
    expect(superview.constraints).to.haveCountOf(2);
    [composite deactivate];
    expect(superview.constraints).to.haveCountOf(0);
    [composite activate];
    expect(superview.constraints).to.haveCountOf(2);
}

- (void)testAttributeChainingShouldCallDelegate {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_left],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:view.mas_right]
    ];
    composite = [[MASCompositeConstraint alloc] initWithChildren:children];
    composite.delegate = delegate;
    expect(composite.childConstraints.count).to.equal(2);
    
    MASConstraint *result = (id)composite.and.bottom;
    expect(result).to.beIdenticalTo(composite);
    expect(delegate.chainedConstraints).to.equal(@[composite]);
    expect(composite.childConstraints.count).to.equal(3);
    
    MASViewConstraint *newChild = composite.childConstraints[2];
    
    expect(newChild.firstViewAttribute.layoutAttribute).to.equal(@(NSLayoutAttributeBottom));
    expect(newChild.delegate).to.beIdenticalTo(composite);
}

SpecEnd
