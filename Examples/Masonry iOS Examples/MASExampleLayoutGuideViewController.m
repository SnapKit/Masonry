//
//  MASExampleLayoutGuideViewController.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 26/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLayoutGuideViewController.h"

@interface MASExampleLayoutGuideViewController ()

@end

@implementation MASExampleLayoutGuideViewController

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.title = @"Layout Guides";

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *topView = UIView.new;
    topView.backgroundColor = UIColor.greenColor;
    topView.layer.borderColor = UIColor.blackColor.CGColor;
    topView.layer.borderWidth = 2;
    [self.view addSubview:topView];

    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = UIColor.redColor;
    bottomView.layer.borderColor = UIColor.blackColor.CGColor;
    bottomView.layer.borderWidth = 2;
    [self.view addSubview:bottomView];

    // TODO find way that avoids casting
    // layoutGuides are actually UIView subclasses so can be used in Masonry
    // However casting to UIView is not ideal if Apple decides to change underlying implementation of layoutGuides this will break
    [topView makeConstraints:^(MASConstraintMaker *make) {
        UIView *topLayoutGuide = (id)self.topLayoutGuide;
        make.top.equalTo(topLayoutGuide.bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];

    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        UIView *bottomLayoutGuide = (id)self.bottomLayoutGuide;
        make.bottom.equalTo(bottomLayoutGuide.top);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
}

@end
