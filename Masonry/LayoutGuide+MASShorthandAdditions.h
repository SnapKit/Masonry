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

@property (nonatomic, readonly) MASViewAttribute *left;
@property (nonatomic, readonly) MASViewAttribute *top;
@property (nonatomic, readonly) MASViewAttribute *right;
@property (nonatomic, readonly) MASViewAttribute *bottom;
@property (nonatomic, readonly) MASViewAttribute *leading;
@property (nonatomic, readonly) MASViewAttribute *trailing;
@property (nonatomic, readonly) MASViewAttribute *width;
@property (nonatomic, readonly) MASViewAttribute *height;
@property (nonatomic, readonly) MASViewAttribute *centerX;
@property (nonatomic, readonly) MASViewAttribute *centerY;

@property (nonatomic, copy, readonly) MASViewAttribute * (^attribute)(NSLayoutAttribute attr);

- (NSArray *)makeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END

#endif
