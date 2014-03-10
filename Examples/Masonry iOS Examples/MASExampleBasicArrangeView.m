//
//  MASExampleBasicView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleBasicArrangeView.h"
#import "MASArrangeConstraintMaker.h"

@implementation MASExampleBasicArrangeView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIView *view1 = UIView.new;
    view1.backgroundColor = UIColor.greenColor;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    view1.layer.borderWidth = 2;
    [self addSubview:view1];

    UIView *view2 = UIView.new;
    view2.backgroundColor = UIColor.redColor;
    view2.layer.borderColor = UIColor.blackColor.CGColor;
    view2.layer.borderWidth = 2;
    [self addSubview:view2];

    UIView *view3 = UIView.new;
    view3.backgroundColor = UIColor.blueColor;
    view3.layer.borderColor = UIColor.blackColor.CGColor;
    view3.layer.borderWidth = 2;
    [self addSubview:view3];

    UIView *superview = self;
    int padding = 10;

    [@[view1, view2, view3] mas_makeArrangeConstraints:^(MASArrangeConstraintMaker *make) {
        make.arrange.vertically.equalTo(@10);
    }];

    [@[view1, view2, view3] makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview).offset(padding);
        make.right.equalTo(superview).offset(-padding);
        make.height.equalTo(@50);
    }];

    return self;
}

@end
