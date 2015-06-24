//
//  ViewController_MASAdditions.h
//  Masonry
//
//  Created by Ray Lillywhite on 6/23/15.
//  Copyright © 2015 Jonas Budelmann. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
@class MASViewAttribute;
@interface UIViewController (MASAdditions)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_topLayoutGuide;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_bottomLayoutGuide;

@end
#endif
