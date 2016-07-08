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
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.mas_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.mas_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withMaximumItemLength:(CGFloat)maximumItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    NSAssert(self.count>1,@"views to distribute need to bigger than one");
    
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    MAS_VIEW *prev;
    __block CGFloat offset = (CGFloat)(maximumItemLength + leadSpacing);
    CGFloat offsetDiff = (CGFloat)(maximumItemLength + leadSpacing + tailSpacing) / (CGFloat)(self.count - 1);
    if (axisType == MASAxisTypeHorizontal) {
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.lessThanOrEqualTo(tempSuperView.mas_width).dividedBy(self.count);
                make.width.equalTo(@(maximumItemLength)).with.priorityLow();
                if (prev) {
                    make.width.equalTo(prev.mas_width);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        offset -= offsetDiff;
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset).with.priorityLow();
                    }
                    make.left.equalTo(prev.mas_right).with.offset(offsetDiff);
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.lessThanOrEqualTo(tempSuperView.mas_height).dividedBy(self.count);
                make.height.equalTo(@(maximumItemLength)).with.priorityLow();
                if (prev) {
                    make.height.equalTo(prev.mas_height);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        offset -= offsetDiff;
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset).with.priorityLow();
                    }
                    make.top.equalTo(prev.mas_bottom).with.offset(offsetDiff);
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == MASAxisTypeHorizontal) {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                    make.width.equalTo(@(fixedItemLength));
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                    make.width.equalTo(@(fixedItemLength));
                }
            }];
            prev = v;
        }
    }
    else {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = self[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                    make.height.equalTo(@(fixedItemLength));
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                    make.height.equalTo(@(fixedItemLength));
                }
            }];
            prev = v;
        }
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
