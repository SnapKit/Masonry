//
//  LayoutGuide+MASShorthandAdditions.h
//  Masonry
//
//  Created by v on 2021/6/1.
//  Copyright © 2021 Jonas Budelmann. All rights reserved.
//

#import "LayoutGuide+MASAdditions.h"

#ifdef MAS_SHORTHAND

NS_ASSUME_NONNULL_BEGIN

/**
 *    Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
API_AVAILABLE(macos(10.11), ios(9.0))
@interface MASLayoutGuide (MASShorthandAdditions)

@property (nonatomic, strong, readonly) MASViewAttribute *left;
@property (nonatomic, strong, readonly) MASViewAttribute *top;
@property (nonatomic, strong, readonly) MASViewAttribute *right;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *leading;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *width;
@property (nonatomic, strong, readonly) MASViewAttribute *height;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY;

@property (nonatomic, strong, readonly) MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END

#endif
