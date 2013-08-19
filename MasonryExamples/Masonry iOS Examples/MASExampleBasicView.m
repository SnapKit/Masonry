//
//  MASExampleBasicView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleBasicView.h"

@implementation MASExampleBasicView

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

    //if you want to use Masonry without the mas_ prefix
    //define MAS_SHORTHAND before importing Masonry.h see Masonry iOS Examples-Prefix.pch
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(view3.top).offset(-padding);
        make.right.equalTo(view2.left).offset(-padding);
        make.width.equalTo(view2.width);

        make.height.equalTo(view2.height);
        make.height.equalTo(view3.height);
    }];

    //with is semantic and option
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding); //with with
        make.left.equalTo(view1.mas_right).offset(padding); //without with
        make.bottom.equalTo(view3.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(view1.mas_width);
        
        make.height.equalTo(@[view1, view3]); //can pass array of views
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(@[view1.mas_height, view2.mas_height]); //can pass array of attributes
    }];

    return self;
}

@end
