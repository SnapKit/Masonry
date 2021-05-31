//
//  UIView+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASAdditions.h"

#ifdef MAS_SHORTHAND

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

@implementation MAS_VIEW (MASShorthandAdditions)

MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);
MAS_ATTR_FORWARD(baseline);

MAS_ATTR_FORWARD(firstBaseline);
MAS_ATTR_FORWARD(lastBaseline);

#if TARGET_OS_IPHONE || TARGET_OS_TV

MAS_ATTR_FORWARD(leftMargin);
MAS_ATTR_FORWARD(rightMargin);
MAS_ATTR_FORWARD(topMargin);
MAS_ATTR_FORWARD(bottomMargin);
MAS_ATTR_FORWARD(leadingMargin);
MAS_ATTR_FORWARD(trailingMargin);
MAS_ATTR_FORWARD(centerXWithinMargins);
MAS_ATTR_FORWARD(centerYWithinMargins);

MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideLeading, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideTrailing, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideLeft, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideRight, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideTop, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideBottom, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideWidth, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideHeight, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideCenterX, API_AVAILABLE(ios(11.0)));
MAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideCenterY, API_AVAILABLE(ios(11.0)));

#endif

- (MASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
