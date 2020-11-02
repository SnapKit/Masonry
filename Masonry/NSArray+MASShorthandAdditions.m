//
//  NSArray+MASShorthandAdditions.m
//  Masonry
//
//  Created by matt on 2020/11/2.
//  Copyright © 2020 Jonas Budelmann. All rights reserved.
//

#import "NSArray+MASShorthandAdditions.h"

@implementation NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end
