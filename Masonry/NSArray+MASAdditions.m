//
//  NSArray+MASAdditions.m
//
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+MASAdditions.h"
#import "View+MASAdditions.h"

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

- (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view mas_remakeConstraints:block]];
    }
    return constraints;
}

- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }

    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == MASAxisTypeHorizontal) {
        MAS_VIEW *v = [self firstObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempSuperView).offset(leadSpacing);
        }];

        MAS_VIEW *prev = v;
        for (int i = 1; i < self.count - 1; i++) {
            v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(prev);
                make.left.equalTo(prev.mas_right).offset(fixedSpacing);
            }];
            prev = v;
        }

        v = [self lastObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(prev);
            make.left.equalTo(prev.mas_right).offset(fixedSpacing);
            make.right.equalTo(tempSuperView).offset(-tailSpacing);
        }];
    }
    else {
        MAS_VIEW *v = [self firstObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tempSuperView).offset(leadSpacing);
        }];

        MAS_VIEW *prev = v;
        for (int i = 1; i < self.count - 1; i++) {
            v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(prev);
                make.top.equalTo(prev.mas_bottom).offset(fixedSpacing);
            }];
            prev = v;
        }

        v = [self lastObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(prev);
            make.top.equalTo(prev.mas_bottom).offset(fixedSpacing);
            make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
        }];
    }
}

- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }

    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == MASAxisTypeHorizontal) {
        MAS_VIEW *v = [self firstObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempSuperView).offset(leadSpacing);
            make.width.equalTo(@(fixedItemLength));
        }];

        MAS_VIEW *prev = v;
        for (int i = 1; i < self.count - 1; i++) {
            v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                make.width.equalTo(@(fixedItemLength));
                make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
            }];
            prev = v;
        }

        v = [self lastObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(fixedItemLength));
            make.right.equalTo(tempSuperView).offset(-tailSpacing);
        }];
    }
    else {
        MAS_VIEW *v = [self firstObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tempSuperView).offset(leadSpacing);
            make.height.equalTo(@(fixedItemLength));
        }];

        MAS_VIEW *prev = v;
        for (int i = 1; i < self.count - 1; i++) {
            v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                make.height.equalTo(@(fixedItemLength));
                make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
            }];
            prev = v;
        }

        v = [self lastObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(fixedItemLength));
            make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
        }];
    }
}

- (MAS_VIEW *)mas_commonSuperviewOfViews
{
    MAS_VIEW *commonSuperview = nil;
    MAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[MAS_VIEW class]]) {
            MAS_VIEW *view = (MAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view mas_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
