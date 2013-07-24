//
//  MASAttribute.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASViewAttribute : NSObject

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;

- (id)initWithView:(UIView *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute;

/**
 Creates a MASConstraintMaker with the callee view. any constraints defined are added to the view or the appropriate superview once the block has finished executing

 @return YES if layoutAttribute is equal to NSLayoutAttributeWidth or NSLayoutAttributeHeight
 */
- (BOOL)isSizeAttribute;

@end
