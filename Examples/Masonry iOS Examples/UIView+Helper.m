//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//




#import "UIView+Helper.h"


@implementation UIView (Helper)

- (UIView *)addColoredView:(UIColor *)c {
    UIView *view1 = UIView.new;
    view1.backgroundColor = c;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    view1.layer.borderWidth = 1;
    [self addSubview:view1];
    return view1;
}

@end