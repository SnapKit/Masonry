//
//  MASExampleAnimatedView.m
//  MasonryExamples
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleAnimatedView.h"

@interface MASExampleAnimatedView ()

@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;

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

    [view1 mas_buildConstraints:^(MASConstraintBuilder *constraints) {
        [self.animatableConstraints addObjectsFromArray:@[
         constraints.sides.equal(superview).insets(paddingInsets).priorityLow(),
         constraints.bottom.equal(view3.mas_top).offset(-padding),
         constraints.right.equal(view2.mas_left).offset(-padding),
         ]];

        constraints.size.equal(view2);
        constraints.height.equal(view3.mas_height);
    }];

    [view2 mas_buildConstraints:^(MASConstraintBuilder *constraints) {
        [self.animatableConstraints addObjectsFromArray:@[
         constraints.sides.equal(superview).insets(paddingInsets).priorityLow(),
         constraints.left.equal(view1.mas_right).offset(padding),
         constraints.bottom.equal(view3.mas_top).offset(-padding),
         ]];

        constraints.size.equal(view1);
        constraints.height.equal(view3.mas_height);
    }];

    [view3 mas_buildConstraints:^(MASConstraintBuilder *constraints) {
        [self.animatableConstraints addObjectsFromArray:@[
         constraints.sides.equal(superview).insets(paddingInsets).priorityLow(),
         constraints.top.equal(view1.mas_bottom).offset(padding),
         ]];

        //TODO or pass an array
        //constraints.height.equal(superview.subviews);
        constraints.height.equal(view1.mas_height);
        constraints.height.equal(view2.mas_height);
    }];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWithGestureRecognizer:)];
    [self addGestureRecognizer:tapGestureRecognizer];

    return self;
}

- (void)didTapWithGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    self.padding += 20;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    for (id<MASConstraint> constraint in self.animatableConstraints) {
        constraint.insets(paddingInsets);
    }

    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

@end

