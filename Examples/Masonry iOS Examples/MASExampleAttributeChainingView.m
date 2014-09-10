//
//  MASExampleAttributeChainingView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 31/03/14.
//  Copyright (c) 2014 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAttributeChainingView.h"

@implementation MASExampleAttributeChainingView

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
    UIEdgeInsets padding = UIEdgeInsetsMake(15, 10, 15, 10);


    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        // chain attributes
        make.top.and.left.equalTo(superview).insets(padding);

        // which is the equivalent of
//        make.top.greaterThanOrEqualTo(superview).insets(padding);
//        make.left.greaterThanOrEqualTo(superview).insets(padding);

        make.bottom.equalTo(view3.mas_top).insets(padding);
        make.right.equalTo(view2.mas_left).insets(padding);
        make.width.equalTo(view2.mas_width);

        make.height.equalTo(@[view2, view3]);
    }];

    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        // chain attributes
        make.top.and.right.equalTo(superview).insets(padding);

        make.left.equalTo(view1.mas_right).insets(padding);
        make.bottom.equalTo(view3.mas_top).insets(padding);
        make.width.equalTo(view1.mas_width);

        make.height.equalTo(@[view1, view3]);
    }];

    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).insets(padding);

        // chain attributes
        make.left.right.and.bottom.equalTo(superview).insets(padding);

        make.height.equalTo(@[view1, view2]);
    }];

    return self;
}

@end
