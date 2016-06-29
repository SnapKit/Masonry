//
//  MASExampleAspectFitView.m
//  Masonry iOS Examples
//
//  Created by Michael Koukoullis on 19/01/2015.
//  Copyright (c) 2015 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAspectFitView.h"

@interface MASExampleAspectFitView ()
@property UIView *topView;
@property UIView *topInnerView;
@property UIView *bottomView;
@property UIView *bottomInnerView;
@end

@implementation MASExampleAspectFitView

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        // Create views
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        self.topInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // Set background colors
        UIColor *blueColor = [UIColor colorWithRed:0.663 green:0.796 blue:0.996 alpha:1];
        [self.topView setBackgroundColor:blueColor];

        UIColor *lightGreenColor = [UIColor colorWithRed:0.784 green:0.992 blue:0.851 alpha:1];
        [self.topInnerView setBackgroundColor:lightGreenColor];

        UIColor *pinkColor = [UIColor colorWithRed:0.992 green:0.804 blue:0.941 alpha:1];
        [self.bottomView setBackgroundColor:pinkColor];
        
        UIColor *darkGreenColor = [UIColor colorWithRed:0.443 green:0.780 blue:0.337 alpha:1];
        [self.bottomInnerView setBackgroundColor:darkGreenColor];
        
        // Layout top and bottom views to each take up half of the window
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.top.equalTo(self);
        }];
        
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(self);
            make.top.equalTo(self.topView.mas_bottom);
            make.height.equalTo(self.topView);
        }];
        
        // Inner views are configured for aspect fit with ratio of 3:1
        [self.topView addSubview:self.topInnerView];
        [self.topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.topInnerView.mas_height).multipliedBy(3);
            
            make.width.and.height.lessThanOrEqualTo(self.topView);
            make.width.and.height.equalTo(self.topView).with.priorityLow();
            
            make.center.equalTo(self.topView);
        }];
        
        [self.bottomView addSubview:self.bottomInnerView];
        [self.bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.bottomInnerView.mas_width).multipliedBy(3);
            
            make.width.and.height.lessThanOrEqualTo(self.bottomView);
            make.width.and.height.equalTo(self.bottomView).with.priorityLow();
                        
            make.center.equalTo(self.bottomView);
        }];
    }
    
    return self;
}

@end
