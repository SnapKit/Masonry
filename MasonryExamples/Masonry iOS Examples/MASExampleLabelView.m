//
//  MASExampleLabelView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 24/10/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLabelView.h"

static UIEdgeInsets const kPadding = {10, 10, 10, 10};

@interface MASExampleLabelView ()

@property (nonatomic, strong) UIButton *bigButton;
@property (nonatomic, strong) UILabel *shortLabel;
@property (nonatomic, strong) UILabel *longLabel;

@end

@implementation MASExampleLabelView

- (id)init {
    self = [super init];
    if (!self) return nil;

    // text courtesy of http://baconipsum.com/

    self.bigButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.bigButton setTitle:@"Big Button" forState:UIControlStateNormal];
    [self.bigButton setContentEdgeInsets:UIEdgeInsetsMake(20, 5, 20, 5)];
    self.bigButton.layer.borderColor = UIColor.blueColor.CGColor;
    self.bigButton.layer.borderWidth = 1;
    [self addSubview:self.bigButton];

    self.shortLabel = UILabel.new;
    self.shortLabel.numberOfLines = 3;
    self.shortLabel.textColor = [UIColor purpleColor];
    self.shortLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.shortLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock.";
    [self addSubview:self.shortLabel];

    self.longLabel = UILabel.new;
    self.longLabel.numberOfLines = 8;
    self.longLabel.textColor = [UIColor darkGrayColor];
    self.longLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.longLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock.";
    [self addSubview:self.longLabel];

    [self.bigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).insets(kPadding);
        make.right.equalTo(self).insets(kPadding);
        // you don't need to define height or width as some UIView's such as UIButtons, UIImageViews and a few others have intrinsicContentSize
    }];

    [self.shortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).insets(kPadding);
        make.left.equalTo(self).insets(kPadding);
    }];

    [self.longLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortLabel.mas_bottom).offset(kPadding.bottom);
        make.left.equalTo(self).insets(kPadding);
    }];

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // for multiline UILabel's you need set the preferredMaxLayoutWidth
    // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point

    // stay tuned for new easier way todo this coming soon to Masonry

    NSInteger textMargin = 5;
    self.shortLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.frame) - CGRectGetWidth(self.bigButton.frame) - kPadding.left - kPadding.right - textMargin;

    self.longLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.frame) - kPadding.left - kPadding.right;

    // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
    [super layoutSubviews];
}

@end
