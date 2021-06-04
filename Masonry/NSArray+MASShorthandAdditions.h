//
//  NSArray+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+MASAdditions.h"

#ifdef MAS_SHORTHAND

NS_ASSUME_NONNULL_BEGIN

/**
 *	Shorthand array additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END

#endif
