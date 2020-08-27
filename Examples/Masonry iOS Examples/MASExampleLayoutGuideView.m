//
//  MASExampleLayoutGuideView.m
//  Masonry iOS Examples
//
//  Created by zhiqiang_ye on 2020/8/25.
//  Copyright © 2020 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLayoutGuideView.h"

@implementation MASExampleLayoutGuideView

#ifdef MAS_LAYOUT_GUIDE

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    [self example1];
    
    return self;
}

- (void)example1{
    
    MAS_VIEW *contentView = MAS_VIEW.new;
    contentView.backgroundColor = self.randomColor;
    contentView.layer.borderColor = self.randomColor.CGColor;
    contentView.layer.borderWidth = 2;
    [self addSubview:contentView];
    
    MAS_VIEW *leftView = MAS_VIEW.new;
    leftView.backgroundColor = self.randomColor;
    leftView.layer.borderColor = self.randomColor.CGColor;
    leftView.layer.borderWidth = 2;
    [contentView addSubview:leftView];
    
    MAS_VIEW *rightView = MAS_VIEW.new;
    rightView.backgroundColor = self.randomColor;
    rightView.layer.borderColor = self.randomColor.CGColor;
    rightView.layer.borderWidth = 2;
    [contentView addSubview:rightView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalToSuperview();
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    MAS_LAYOUT_GUIDE *layout = [MAS_LAYOUT_GUIDE mas_allocWithOwningView:contentView];
    [layout mas_makeConstraints:^(MASConstraintMaker * _Nonnull make) {
        make.center.equalToSuperview();
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(layout);
        make.right.mas_equalTo(layout.mas_left);
        make.bottom.mas_equalTo(layout);
        make.width.mas_equalTo(layout.mas_width);
    }];
    
    [rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(layout);
        make.left.mas_equalTo(layout.mas_right);
        make.bottom.mas_equalTo(layout);
        make.width.mas_equalTo(layout.mas_width);
    }];
}

#endif

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
