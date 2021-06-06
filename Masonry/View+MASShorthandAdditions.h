//
//  View+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASAdditions.h"

#ifdef MAS_SHORTHAND

NS_ASSUME_NONNULL_BEGIN

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface MAS_VIEW (MASShorthandAdditions)

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
@property (nonatomic, readonly) MASViewAttribute *baseline;

@property (nonatomic, copy, readonly) MASViewAttribute * (^attribute)(NSLayoutAttribute attr);

@property (nonatomic, readonly) MASViewAttribute *firstBaseline;
@property (nonatomic, readonly) MASViewAttribute *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, readonly) MASViewAttribute *leftMargin;
@property (nonatomic, readonly) MASViewAttribute *rightMargin;
@property (nonatomic, readonly) MASViewAttribute *topMargin;
@property (nonatomic, readonly) MASViewAttribute *bottomMargin;
@property (nonatomic, readonly) MASViewAttribute *leadingMargin;
@property (nonatomic, readonly) MASViewAttribute *trailingMargin;
@property (nonatomic, readonly) MASViewAttribute *centerXWithinMargins;
@property (nonatomic, readonly) MASViewAttribute *centerYWithinMargins;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideLeading API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideTrailing API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideWidth API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideHeight API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideCenterX API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *safeAreaLayoutGuideCenterY API_AVAILABLE(ios(11.0));

#endif

- (NSArray *)makeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END

#endif
