//
//  NSArray+MASAdditions.m
//
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+MASAdditions.h"
#import "View+MASAdditions.h"
#import "MASArrangeConstraintMaker.h"

@implementation NSArray (MASAdditions)

- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view mas_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view mas_updateConstraints:block]];
    }
    return constraints;
}

#pragma mark -  MASArrangeConstraintMaker


- (NSArray *)mas_makeArrangeConstraints:(void(^)(MASArrangeConstraintMaker *make))block {
    MASArrangeConstraintMaker *constraintMaker = [[MASArrangeConstraintMaker alloc] initWithViews:self];
    block(constraintMaker);
    return [constraintMaker install];
}

@end
