//
//  MASExampleArrayView.m
//  Masonry iOS Examples
//
//  Created by Daniel Hammond on 11/26/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleArrayView.h"

static CGFloat const kArrayExampleIncrement = 10.0;

@interface MASExampleArrayView ()

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) NSArray *buttonViews;

@end

@implementation MASExampleArrayView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIButton *raiseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [raiseButton setTitle:@"Raise" forState:UIControlStateNormal];
    [raiseButton addTarget:self action:@selector(raiseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:raiseButton];
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [centerButton setTitle:@"Center" forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:centerButton];

    UIButton *lowerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [lowerButton setTitle:@"Lower" forState:UIControlStateNormal];
    [lowerButton addTarget:self action:@selector(lowerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lowerButton];
    
    [lowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10.0);
    }];

    [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];

    [raiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
    }];
    
    self.buttonViews = @[ raiseButton, lowerButton, centerButton ];
    
    return self;
}

- (void)centerAction {
    self.offset = 0.0;
}

- (void)raiseAction {
    self.offset -= kArrayExampleIncrement;
}

- (void)lowerAction {
    self.offset += kArrayExampleIncrement;
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.buttonViews updateConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.mas_centerY).with.offset(self.offset);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

@end
