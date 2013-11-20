//
//  MASExampleScrollView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 20/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleScrollView.h"

/**
 *  UIScrollView and Auto Layout don't play very nicely together see
 *  https://developer.apple.com/library/ios/technotes/tn2154/_index.html
 *
 *  This is an example of one workaround
 *
 *  for another approach see https://github.com/bizz84/MVScrollViewAutoLayout
 */

@implementation MASExampleScrollView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIScrollView *scrollView = UIScrollView.new;
    scrollView.backgroundColor = [UIColor grayColor];
    [self addSubview:scrollView];

    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    UIView *lastView;
    CGFloat height = 20;

    for (int i = 0; i < 10; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        [scrollView addSubview:view];

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.bottom : @0);
            make.left.equalTo(@0);
            make.width.equalTo(scrollView.width);
            make.height.equalTo(@(height));
        }];

        height += 20;
        lastView = view;
    }

    // dummy view, which determines the contentSize of scroll view
    UIView *sizingView = UIView.new;
    [scrollView addSubview:sizingView];

    [sizingView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.bottom);
        make.bottom.equalTo(scrollView.bottom);
    }];

    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
