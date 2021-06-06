//
//  MASExampleUpdateView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleUpdateView.h"

@interface MASExampleUpdateView ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;

@end

@implementation MASExampleUpdateView

- (instancetype)init {
    if (self = [super init]) {
        self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
        self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
        self.growingButton.layer.borderWidth = 3;

        [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.growingButton];
        [self.growingButton makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@(self.buttonSize.width)).priorityLow();
            make.height.equalTo(@(self.buttonSize.height)).priorityLow();
            make.width.lessThanOrEqualTo(self);
            make.height.lessThanOrEqualTo(self);
        }];
    }
    
    self.buttonSize = CGSizeMake(100, 100);

    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)didTapGrowButton:(UIButton *)button {
    self.buttonSize = CGSizeMake(self.buttonSize.width * 1.3, self.buttonSize.height * 1.3);
    [self.growingButton updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.buttonSize.width)).priorityLow();
        make.height.equalTo(@(self.buttonSize.height)).priorityLow();
    }];
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];

    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
