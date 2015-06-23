//
//  UIViewController+MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+MASAdditions.h"

#ifdef MAS_VIEW_CONTROLLER

@implementation MAS_VIEW_CONTROLLER (MASAdditions)

- (MASViewAttribute *)mas_topLayoutGuide {
    return [[MASViewAttribute alloc] initWithView:(UIView *)self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_bottomLayoutGuide {
    return [[MASViewAttribute alloc] initWithView:(UIView *)self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}

@end

#endif
