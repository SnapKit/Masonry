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
@property (nonatomic, strong, readonly) MASViewAttribute *baseline;
@property (nonatomic, strong, readonly) MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

@property (nonatomic, strong, readonly) MASViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) MASViewAttribute *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) MASViewAttribute *centerYWithinMargins;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideLeading API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideTrailing API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideWidth API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideHeight API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideCenterX API_AVAILABLE(ios(11.0));
@property (nonatomic, strong, readonly) MASViewAttribute *safeAreaLayoutGuideCenterY API_AVAILABLE(ios(11.0));

#endif

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END

#endif
