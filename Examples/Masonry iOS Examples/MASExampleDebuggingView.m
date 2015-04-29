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

    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];

    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];

    UILabel *blueView = UILabel.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.numberOfLines = 3;
    blueView.textAlignment = NSTextAlignmentCenter;
    blueView.font = [UIFont systemFontOfSize:24];
    blueView.textColor = UIColor.whiteColor;
    blueView.text = @"this should look broken! check your console!";
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];

    UIView *superview = self;
    int padding = 10;

    //you can attach debug keys to views like so:
//    greenView.mas_key = @"greenView";
//    redView.mas_key = @"redView";
//    blueView.mas_key = @"blueView";
//    superview.mas_key = @"superview";

    //OR you can attach keys automagically like so:
    MASAttachKeys(greenView, redView, blueView, superview);

    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        //you can also attach debug keys to constaints
        make.edges.equalTo(@1).key(@"ConflictingConstraint"); //composite constraint keys will be indexed
        make.height.greaterThanOrEqualTo(@5000).key(@"ConstantConstraint");

        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding).key(@"BottomConstraint");
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(greenView.mas_height);
        make.height.equalTo(redView.mas_height).key(@340954); //anything can be a key
    }];
    
    [greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(blueView.top).offset(-padding);
        make.right.equalTo(redView.left).offset(-padding);
        make.width.equalTo(redView.width);

        make.height.equalTo(redView.height);
        make.height.equalTo(blueView.height);
    }];

    //with is semantic and option
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding);
        make.left.equalTo(greenView.mas_right).offset(padding);
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(greenView.mas_width);

        make.height.equalTo(@[greenView, blueView]);
    }];
    
    return self;
}

@end
