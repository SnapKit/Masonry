//
//  View+MASShorthandAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASShorthandAdditions.h"

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
