//
//  LayoutGuide+MASAdditions.m
//  Masonry
//
//  Created by v on 2021/5/30.
//  Copyright © 2021 Jonas Budelmann. All rights reserved.
//

#import "LayoutGuide+MASAdditions.h"
#import <objc/runtime.h>


@implementation MASLayoutGuide (MASAdditions)

- (NSArray *)mas_makeConstraints:(void (NS_NOESCAPE^)(id<MASLayoutConstraint> make))block {
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithLayoutGuide:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void (NS_NOESCAPE^)(id<MASLayoutConstraint> make))block {
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithLayoutGuide:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void (NS_NOESCAPE^)(id<MASLayoutConstraint> make))block {
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithLayoutGuide:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (MASViewAttribute *)mas_left {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)mas_top {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTop];
}

- (MASViewAttribute *)mas_right {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeRight];
}

- (MASViewAttribute *)mas_bottom {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_leading {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)mas_trailing {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)mas_width {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)mas_height {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)mas_centerX {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)mas_centerY {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (MASViewAttribute * (^)(NSLayoutAttribute))mas_attribute {
    return ^(NSLayoutAttribute attr) {
        return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:attr];
    };
}

@end
