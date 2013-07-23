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
    
    [view1 mas_buildConstraints:^(MASConstraintBuilder *constrain) {
        constrain.top.equal(@20);
        constrain.left.equal(@20);
        constrain.bottom.equal(@-20);
        constrain.right.equal(@-20);
    }];
    
    [view2 mas_buildConstraints:^(MASConstraintBuilder *constrain) {
        constrain.centerY.equal(@50);
        constrain.centerX.equal(@0);
        constrain.width.equal(@200);
        constrain.height.equal(@100);
    }];
    
    return self;
}

@end
