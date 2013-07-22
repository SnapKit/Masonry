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
    
    [view1 mas_buildConstraints:^(MASConstraintBuilder *constraints) {
        constraints.top.equal(@20);
        constraints.left.equal(@20);
        constraints.bottom.equal(@-20);
        constraints.right.equal(@-20);
    }];
    
    [view2 mas_buildConstraints:^(MASConstraintBuilder *constraints) {
        constraints.centerY.equal(@50);
        constraints.centerX.equal(@0);
        constraints.width.equal(@200);
        constraints.height.equal(@100);
    }];
    
    return self;
}

@end
