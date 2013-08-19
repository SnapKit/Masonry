//
//  MASExampleConstantsView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleConstantsView.h"

@implementation MASExampleConstantsView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *view1 = UIView.new;
    view1.backgroundColor = UIColor.purpleColor;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    view1.layer.borderWidth = 2;
    [self addSubview:view1];
    
    UIView *view2 = UIView.new;
    view2.backgroundColor = UIColor.orangeColor;
    view2.layer.borderColor = UIColor.blackColor.CGColor;
    view2.layer.borderWidth = 2;
    [self addSubview:view2];
    
    //example of using constants
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.right.equalTo(@-20);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@50);
        make.centerX.equalTo(@0);
        make.width.equalTo(@200);
        make.height.equalTo(@100);
    }];
    
    return self;
}

@end
