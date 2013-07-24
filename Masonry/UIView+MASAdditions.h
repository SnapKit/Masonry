//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

@interface UIView (MASAdditions)

// following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
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
@property (nonatomic, strong, readonly) MASViewAttribute *mas_baseline;

/**
 Creates a MASConstraintMaker with the callee view. any constraints defined are added to the view or the appropriate superview once the block has finished executing

 @param block scope within which you can build up the constraints which you wish to apply to the view.
 */
- (void)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;

@end