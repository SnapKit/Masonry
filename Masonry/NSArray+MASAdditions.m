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

- (void)mas_distributeViewsAlongAxis:(AxisType)axisType withFixedSpacing:(CGFloat)paddingSpace withLeadSpacing:(CGFloat)leadSpacing {
    if (self.count < 2) {
        return;
    }
    
    UIView *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == AxisTypeHorizon) {
        UIView *prev;
        for (int i = 0; i < self.count; i++) {
            UIView *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.left.equalTo(prev.mas_right).offset(paddingSpace);
                    make.width.equalTo(prev);
                }
                else {
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                if (i == (CGFloat)self.count - 1) {
                    make.right.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        UIView *prev;
        for (int i = 0; i < self.count; i++) {
            UIView *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.top.equalTo(prev.mas_bottom).offset(paddingSpace);
                    make.height.equalTo(prev);
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                if (i == (CGFloat)self.count - 1) {
                    make.bottom.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (void)mas_distributeViewsAlongAxis:(AxisType)axisType withFixedItemLength:(CGFloat)itemLength withLeadSpacing:(CGFloat)leadSpacing {
    if (self.count < 2) {//一个不需要均匀分布
        return;
    }
    
    UIView *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == AxisTypeHorizon) {
        UIView *prev;
        for (int i = 0; i < self.count; i++) {
            UIView *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*itemLength;
                    make.width.equalTo(@(itemLength));
                    make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                }
                else {
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                    make.width.equalTo(@(itemLength));
                }
                if (i == (CGFloat)self.count - 1) {
                    make.right.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        UIView *prev;
        for (int i = 0; i < self.count; i++) {
            UIView *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*itemLength;
                    make.height.equalTo(@(itemLength));
                    make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                    make.height.equalTo(@(itemLength));
                }
                if (i == (CGFloat)self.count - 1) {
                    make.bottom.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (UIView *)mas_commonSuperviewOfViews
{
    UIView *commonSuperview = nil;
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
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
