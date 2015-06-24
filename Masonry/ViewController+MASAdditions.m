//
//  NSObject+ViewController_MASAdditions.m
//  Masonry
//
//  Created by Ray Lillywhite on 6/23/15.
//  Copyright © 2015 Jonas Budelmann. All rights reserved.
//

#import "ViewController+MASAdditions.h"
#import "MASViewConstraint.h"

#if TARGET_OS_IPHONE
@implementation UIViewController (MASAdditions)

- (MASViewAttribute *)mas_topLayoutGuide {
    return [[MASViewAttribute alloc] initWithView:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_bottomLayoutGuide {
    return [[MASViewAttribute alloc] initWithView:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}

@end
#endif
