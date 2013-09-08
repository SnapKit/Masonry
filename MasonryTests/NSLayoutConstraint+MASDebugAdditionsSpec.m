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

SpecBegin(NSLayoutConstraint_MASDebugAdditions)

it(@"should display view key", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    newView.mas_key = @"newView";

    MASLayoutConstraint *layoutConstraint = [MASLayoutConstraint constraintWithItem:newView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];

    NSString *description = [NSString stringWithFormat:@"<MASLayoutConstraint:%p %@:newView.width >= 300>", layoutConstraint, MAS_VIEW.class];
    expect([layoutConstraint description]).to.equal(description);
});

it(@"should display layoutConstraint key", ^{
    MAS_VIEW *newView1 = MAS_VIEW.new;
    newView1.mas_key = @"newView1";
    MAS_VIEW *newView2 = MAS_VIEW.new;
    newView2.mas_key = @"newView2";

    MASLayoutConstraint *layoutConstraint = [MASLayoutConstraint constraintWithItem:newView1 attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:newView2 attribute:NSLayoutAttributeTop multiplier:1 constant:300];
    layoutConstraint.mas_key = @"helloConstraint";

    NSString *description = [NSString stringWithFormat:@"<MASLayoutConstraint:helloConstraint %@:newView1.baseline == %@:newView2.top + 300>", MAS_VIEW.class, MAS_VIEW.class];
    expect([layoutConstraint description]).to.equal(description);
});

SpecEnd