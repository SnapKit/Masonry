//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//


#import "MASExampleBasicArrangeView.h"
#import "MASArrangeConstraintMaker.h"
#import "MASArrangeOrientation.h"
#import "UIView+Helper.h"

@implementation MASExampleBasicArrangeView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIView *v1 = [self addTop];
    UIView *v2 = [self addMiddle];
    UIView *v3 = [self addBottomPart];

    [@[v1, v2, v3] mas_makeArrangeConstraints:^(MASArrangeConstraintMaker *make) {
        make.arrange.vertically.ascii(@"|[v1]-[v2(==v1)]-[v3(==v1)]|");
    }];

    [@[v1, v2, v3] makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
    }];

    return self;
}

- (UIView *)addTop {
    UIView *s = [[UIView alloc] init];

    int padding= 10;
    UIView *view1= [s addColoredView:UIColor.redColor];
    UIView *view2 = [s addColoredView:[UIColor greenColor]];
    UIView *view3 = [s addColoredView:[UIColor blueColor]];

    [@[view1, view2, view3] mas_makeArrangeConstraints:^(MASArrangeConstraintMaker *make) {
        make.arrange.vertically.equalTo(@5);
    }];

    [@[view1, view2, view3] makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(s).offset(padding);
        make.right.equalTo(s).offset(-padding);
        make.height.equalTo(s).multipliedBy(.3);
    }];

    [self addSubview:s];
    return s;
}

- (UIView *)addMiddle {
    UIView * s = [[UIView alloc] init];
    UIView *v1 = [s addColoredView:UIColor.redColor];
    UIView *v2 = [s addColoredView:UIColor.greenColor];
    UIView *v3 = [s addColoredView:UIColor.blueColor];
    [@[v1, v2, v3] mas_makeArrangeConstraints:^(MASArrangeConstraintMaker *make) {
        make.arrange.horizontally.ascii(@"|-[v1]-[v2(==v1)]-[v3(==v1)]-|");
    }];

    [@[v1, v2, v3] makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(s);
        make.centerY.equalTo(s);
    }];

    [self addSubview:s];
    return s;
}

- (UIView *)addBottomPart {
    UIView * s = [[UIView alloc] init];
    UIView *v1 = [s addColoredView:UIColor.redColor];
    UIView *v2 = [s addColoredView:UIColor.greenColor];
    UIView *v3 = [s addColoredView:UIColor.blueColor];
    [@[v1, v2, v3] mas_makeArrangeConstraints:^(MASArrangeConstraintMaker *make) {
        make.arrange.vertically.ascii(@"|[v1]-[v2(==v1)]-[v3(==v1)]|");
    }];

    [@[v1, v2, v3] makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(s).offset(10);
        make.right.equalTo(s).offset(-10);
    }];

    [self addSubview:s];
    return s;
}



@end
