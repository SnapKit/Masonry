//
//  MASExampleDebuggingView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleDebuggingView.h"

@implementation MASExampleDebuggingView

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

    UILabel *view3 = UILabel.new;
    view3.backgroundColor = UIColor.blueColor;
    view3.numberOfLines = 3;
    view3.textAlignment = NSTextAlignmentCenter;
    view3.font = [UIFont systemFontOfSize:24];
    view3.textColor = UIColor.whiteColor;
    view3.text = @"this should look broken! check your console!";
    view3.layer.borderColor = UIColor.blackColor.CGColor;
    view3.layer.borderWidth = 2;
    [self addSubview:view3];

    UIView *superview = self;
    int padding = 10;

    //you can attach debug keys to views like so:
//    view1.mas_key = @"view1";
//    view2.mas_key = @"view2";
//    view3.mas_key = @"view3";
//    superview.mas_key = @"superview";

    //OR you can attach keys automagically like so:
    MASAttachKeys(view1, view2, view3, superview);

    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        //you can also attach debug keys to constaints
        make.edges.equalTo(@1).key(@"ConflictingConstraint"); //composite constraint keys will be indexed
        make.height.greaterThanOrEqualTo(@5000).key(@"ConstantConstraint");

        make.top.equalTo(view1.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding).key(@"BottomConstraint");
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(view1.mas_height);
        make.height.equalTo(view2.mas_height).key(@340954); //anything can be a key
    }];
    
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
        make.top.equalTo(superview.mas_top).with.offset(padding);
        make.left.equalTo(view1.mas_right).offset(padding);
        make.bottom.equalTo(view3.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(view1.mas_width);

        make.height.equalTo(@[view1, view3]);
    }];
    
    return self;
}

@end
