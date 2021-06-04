//
//  NSArray+MASShorthandAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+MASShorthandAdditions.h"

@implementation NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end
