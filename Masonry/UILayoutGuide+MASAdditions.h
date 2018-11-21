//
//  UILayoutGuide+MASAdditions.h
//  Masonry iOS
//
//  Created by vvveiii on 2018/11/21.
//  Copyright © 2018 cntrump@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

NS_CLASS_AVAILABLE_IOS(9_0)
@interface UILayoutGuide (MASAdditions)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerY;

@end
