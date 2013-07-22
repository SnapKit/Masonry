//
//  MASAttribute.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASViewAttribute : NSObject

@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;

- (id)initWithView:(UIView *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute;

- (BOOL)isAlignment;

@end
