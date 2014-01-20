//
//  MASExampleAnimatedView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAnimatedView.h"

@interface MASExampleAnimatedView ()

@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;
@property (nonatomic, assign) BOOL animating;

@end

@implementation MASExampleAnimatedView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIView *view1 = UIView.new;
    view1.backgroundColor = UIColor.greenColor;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    view1.layer.borderWidth = 2;
    [self addSubview:view1];

    UIView *view2 = UIView.new;
    view2.backgroundColor = UIColor.redColor;
    view2.layer.borderColor = UIColor.blackColor.CGColor;
    view2.layer.borderWidth = 2;
    [self addSubview:view2];

    UIView *view3 = UIView.new;
    view3.backgroundColor = UIColor.blueColor;
    view3.layer.borderColor = UIColor.blackColor.CGColor;
    view3.layer.borderWidth = 2;
    [self addSubview:view3];

    UIView *superview = self;
    int padding = self.padding = 10;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);

    self.animatableConstraints = NSMutableArray.new;

    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
            make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
            make.bottom.equalTo(view3.mas_top).offset(-padding),
        ]];

        make.size.equalTo(view2);
        make.height.equalTo(view3.mas_height);
    }];

    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
            make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
            make.left.equalTo(view1.mas_right).offset(padding),
            make.bottom.equalTo(view3.mas_top).offset(-padding),
        ]];

        make.size.equalTo(view1);
        make.height.equalTo(view3.mas_height);
    }];

    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
            make.edges.equalTo(superview).insets(paddingInsets).priorityLow(),
        ]];

        make.height.equalTo(view1.mas_height);
        make.height.equalTo(view2.mas_height);
    }];

    return self;
}

- (void)didMoveToWindow {
    [self layoutIfNeeded];

    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    self.animating = newWindow != nil;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;

    int padding = invertedInsets ? 100 : self.padding;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (MASConstraint *constraint in self.animatableConstraints) {
        constraint.insets = paddingInsets;
    }

    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}


@end

