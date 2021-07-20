//
//  MASExampleLayoutMarginsGuideViewController.m
//  Masonry iOS Examples
//
//  Created by Chase Choi on 2021/7/20.
//  Copyright © 2021 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLayoutMarginsGuideViewController.h"

@interface MASExampleLayoutMarginsGuideViewController ()

@end

@implementation MASExampleLayoutMarginsGuideViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Layout Margins Guides";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view3];
    
    UIView *leftView = [self viewWithName:@"LY"];
    UIView *rightView = [self viewWithName:@"RY"];
    UIView *topView = [self viewWithName:@"TX"];
    UIView *bottomView = [self viewWithName:@"BX"];
    
    UIView *leftTopView = [self viewWithName:@"LT"];
    UIView *rightTopView = [self viewWithName:@"RT"];
    UIView *leftBottomView = [self viewWithName:@"LB"];
    UIView *rightBottomView = [self viewWithName:@"RB"];
    
    UIView *centerView = [self viewWithName:@"XY"];
    
    const CGFloat size = 50.0;
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.mas_layoutMarginsGuide).inset(10.0);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(self.view.mas_layoutMarginsGuide).sizeOffset(CGSizeMake(- 40.0, - 40.0));
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.equalTo(self.view.mas_layoutMarginsGuide).sizeOffset(CGSizeMake(- 60.0, - 60.0));
        make.height.equalTo(self.view.mas_layoutMarginsGuide).sizeOffset(CGSizeMake(- 60.0, - 60.0));
    }];
    
    [leftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(@(size));
    }];
    
    [rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_layoutMarginsGuideRight);
        make.top.equalTo(self.view.mas_layoutMarginsGuideTop);
        make.width.height.equalTo(@(size));
    }];
    
    [leftBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_layoutMarginsGuideLeft);
        make.bottom.equalTo(self.view.mas_layoutMarginsGuideBottom);
        make.width.height.equalTo(@(size));
    }];
    
    [rightBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(@(size));
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(@(size));
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_layoutMarginsGuideRight);
        make.centerY.equalTo(self.view.mas_layoutMarginsGuideCenterY);
        make.width.height.equalTo(@(size));
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_layoutMarginsGuideTop);
        make.centerX.equalTo(self.view.mas_layoutMarginsGuideCenterX);
        make.width.height.equalTo(@(size));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(@(size));
    }];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view.mas_layoutMarginsGuide);
        make.width.height.equalTo(@(size));
    }];
}

- (UIView *)viewWithName:(NSString *)name {
    UILabel *label = [UILabel new];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    return label;
}

@end
