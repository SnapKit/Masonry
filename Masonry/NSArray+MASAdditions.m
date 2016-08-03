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

- (MAS_VIEW *)mas_commonSuperviewOfViews {
    
    if (self.count == 1) {
        return ((MAS_VIEW *)self.firstObject).superview;
    }
    
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




- (void)mas_distributeSudokuViewsWithFixedItemWidth:(CGFloat)fixedItemWidth
                                    fixedItemHeight:(CGFloat)fixedItemHeight
                                          warpCount:(NSInteger)warpCount
                                         topSpacing:(CGFloat)topSpacing
                                      bottomSpacing:(CGFloat)bottomSpacing
                                        leadSpacing:(CGFloat)leadSpacing
                                        tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    if (warpCount < 1) {
        NSAssert(false, @"warp count need to bigger than zero");
        return;
    }
    
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    
    NSInteger rowCount = self.count % warpCount == 0 ? self.count / warpCount : self.count / warpCount + 1;
    
    MAS_VIEW *prev;
    for (int i = 0; i < self.count; i++) {
        
        MAS_VIEW *v = self[i];
        
        // 当前行
        NSInteger currentRow = i / warpCount;
        // 当前列
        NSInteger currentColumn = i % warpCount;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            // 固定宽度
            make.width.equalTo(@(fixedItemWidth));
            make.height.equalTo(@(fixedItemHeight));
            
            // 第一行
            if (currentRow == 0) {
                make.top.equalTo(tempSuperView).offset(topSpacing);
            }
            // 最后一行
            if (currentRow == rowCount - 1) {
                make.bottom.equalTo(tempSuperView).offset(-bottomSpacing);
            }
            // 中间的若干行
            if (currentRow != 0 && currentRow != rowCount - 1){
                CGFloat offset = (1-(currentRow/((CGFloat)rowCount-1)))*(fixedItemHeight+topSpacing)-currentRow*bottomSpacing/(((CGFloat)rowCount-1));
                make.bottom.equalTo(tempSuperView).multipliedBy(currentRow/((CGFloat)rowCount-1)).offset(offset);
            }
            
            // 第一列
            if (currentColumn == 0) {
                make.left.equalTo(tempSuperView).offset(leadSpacing);
            }
            // 最后一列
            if (currentColumn == warpCount - 1) {
                make.right.equalTo(tempSuperView).offset(-tailSpacing);
            }
            // 中间若干列
            if (currentColumn != 0 && currentColumn != warpCount - 1) {
                CGFloat offset = (1-(currentColumn/((CGFloat)warpCount-1)))*(fixedItemWidth+leadSpacing)-currentColumn*tailSpacing/(((CGFloat)warpCount-1));
                make.right.equalTo(tempSuperView).multipliedBy(currentColumn/((CGFloat)warpCount-1)).offset(offset);
            }
        }];
        prev = v;
    }
}

- (void)mas_distributeSudokuViewsWithFixedLineSpacing:(CGFloat)fixedLineSpacing
                                fixedInteritemSpacing:(CGFloat)fixedInteritemSpacing
                                            warpCount:(NSInteger)warpCount
                                           topSpacing:(CGFloat)topSpacing
                                        bottomSpacing:(CGFloat)bottomSpacing
                                          leadSpacing:(CGFloat)leadSpacing
                                          tailSpacing:(CGFloat)tailSpacing {
    
    [self mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:0 fixedLineSpacing:fixedLineSpacing fixedInteritemSpacing:fixedInteritemSpacing warpCount:warpCount topSpacing:topSpacing bottomSpacing:bottomSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
}

- (NSArray *)mas_distributeSudokuViewsWithFixedItemWidth:(CGFloat)fixedItemWidth
                                         fixedItemHeight:(CGFloat)fixedItemHeight
                                        fixedLineSpacing:(CGFloat)fixedLineSpacing
                                   fixedInteritemSpacing:(CGFloat)fixedInteritemSpacing
                                               warpCount:(NSInteger)warpCount
                                              topSpacing:(CGFloat)topSpacing
                                           bottomSpacing:(CGFloat)bottomSpacing
                                             leadSpacing:(CGFloat)leadSpacing
                                             tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 1) {
        return self.copy;
    }
    if (warpCount < 1) {
        NSAssert(false, @"warp count need to bigger than zero");
        return self.copy;
    }
    
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    
    NSArray *tempViews = self.copy;
    if (warpCount > self.count) {
        for (int i = 0; i < warpCount - self.count; i++) {
            MAS_VIEW *tempView = [[MAS_VIEW alloc] init];
            [tempSuperView addSubview:tempView];
            tempViews = [tempViews arrayByAddingObject:tempView];
        }
    }
    
    NSInteger columnCount = warpCount;
    NSInteger rowCount = tempViews.count % columnCount == 0 ? tempViews.count / columnCount : tempViews.count / columnCount + 1;
    
    MAS_VIEW *prev;
    for (int i = 0; i < tempViews.count; i++) {
        
        MAS_VIEW *v = tempViews[i];
        NSInteger currentRow = i / columnCount;
        NSInteger currentColumn = i % columnCount;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            if (prev) {
                // 固定宽度
                make.width.equalTo(prev);
                make.height.equalTo(prev);
            }
            else {
                // 如果写的item高宽分别是0，则表示自适应
                if (fixedItemWidth) {
                    make.width.equalTo(@(fixedItemWidth));
                }
                if (fixedItemHeight) {
                    make.height.equalTo(@(fixedItemHeight));
                }
            }
            
            // 第一行
            if (currentRow == 0) {
                make.top.equalTo(tempSuperView).offset(topSpacing);
            }
            // 最后一行
            if (currentRow == rowCount - 1) {
                // 如果只有一行
                if (currentRow != 0 && i-columnCount >= 0) {
                    make.top.equalTo(((MAS_VIEW *)tempViews[i-columnCount]).mas_bottom).offset(fixedLineSpacing);
                }
                make.bottom.equalTo(tempSuperView).offset(-bottomSpacing);
            }
            // 中间的若干行
            if (currentRow != 0 && currentRow != rowCount - 1) {
                make.top.equalTo(((MAS_VIEW *)tempViews[i-columnCount]).mas_bottom).offset(fixedLineSpacing);
            }
            
            // 第一列
            if (currentColumn == 0) {
                make.left.equalTo(tempSuperView).offset(leadSpacing);
            }
            // 最后一列
            if (currentColumn == columnCount - 1) {
                // 如果只有一列
                if (currentColumn != 0) {
                    make.left.equalTo(prev.mas_right).offset(fixedInteritemSpacing);
                }
                make.right.equalTo(tempSuperView).offset(-tailSpacing);
            }
            // 中间若干列
            if (currentColumn != 0 && currentColumn != warpCount - 1) {
                make.left.equalTo(prev.mas_right).offset(fixedInteritemSpacing);
            }
        }];
        prev = v;
    }
    return tempViews;
}


@end
