//
//  NSLayoutConstraint+MASDebugAdditionsSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 8/09/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSLayoutConstraint+MASDebugAdditions.h"
#import "View+MASAdditions.h"
#import "MASLayoutConstraint.h"
#import "MASCompositeConstraint.h"
#import "MASViewConstraint.h"

SpecBegin(NSLayoutConstraint_MASDebugAdditions)

- (void)testDisplayViewKey {
    MAS_VIEW *newView = MAS_VIEW.new;
    newView.mas_key = @"newView";

    MASLayoutConstraint *layoutConstraint = [MASLayoutConstraint constraintWithItem:newView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];

    layoutConstraint.priority = MASLayoutPriorityDefaultLow;

    NSString *description = [NSString stringWithFormat:@"<MASLayoutConstraint:%p %@:newView.width >= 300 ^low>", layoutConstraint, MAS_VIEW.class];
    expect([layoutConstraint description]).to.equal(description);
}

- (void)testDisplayLayoutConstraintKey {
    MAS_VIEW *newView1 = MAS_VIEW.new;
    newView1.mas_key = @"newView1";
    MAS_VIEW *newView2 = MAS_VIEW.new;
    newView2.mas_key = @"newView2";

    MASLayoutConstraint *layoutConstraint = [MASLayoutConstraint constraintWithItem:newView1 attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:newView2 attribute:NSLayoutAttributeTop multiplier:2 constant:300];
    layoutConstraint.mas_key = @"helloConstraint";

    NSString *description = [NSString stringWithFormat:@"<MASLayoutConstraint:helloConstraint %@:newView1.baseline == %@:newView2.top * 2 + 300>", MAS_VIEW.class, MAS_VIEW.class];
    expect([layoutConstraint description]).to.equal(description);
}

- (void)testDisplayConstraintKey {
    MAS_VIEW *superview = MAS_VIEW.new;
    MAS_VIEW *newView1 = MAS_VIEW.new;
    newView1.mas_key = @"newView1";
    MAS_VIEW *newView2 = MAS_VIEW.new;
    newView2.mas_key = @"newView2";
    [superview addSubview:newView1];
    [superview addSubview:newView2];

    [newView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@[newView2, @10]).key(@"left");
    }];


    NSString *description = [NSString stringWithFormat:@"<MASLayoutConstraint:left[0] %@:newView1.left == %@:newView2.left>", MAS_VIEW.class, MAS_VIEW.class];
    expect([superview.constraints[0] description]).to.equal(description);
}

SpecEnd