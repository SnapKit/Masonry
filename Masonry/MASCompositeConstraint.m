//
//  MASCompositeConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASCompositeConstraint.h"
#import "UIView+MASAdditions.h"
#import "MASViewConstraint.h"

@interface MASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *completedChildConstraints;
@property (nonatomic, strong) NSMutableArray *currentChildConstraints;
@property (nonatomic, assign) BOOL added;

@end

@implementation MASCompositeConstraint

- (id)initWithView:(UIView *)view type:(MASCompositeViewConstraintType)type {
    self = [super init];
    if (!self) return nil;
    
    _view = view;
    _type = type;
    
    self.completedChildConstraints = NSMutableArray.array;
    [self createChildren];
    
    return self;
}

- (void)createChildren {
    self.currentChildConstraints = NSMutableArray.array;
    
    NSArray *viewAttributes;
    switch (self.type) {
        case MASCompositeViewConstraintTypeEdges:
            viewAttributes = @[
                self.view.mas_top, self.view.mas_left,
                self.view.mas_bottom, self.view.mas_right
            ];
            break;
        case MASCompositeViewConstraintTypeSize:
            viewAttributes = @[
                self.view.mas_width, self.view.mas_height
            ];
            break;
        case MASCompositeViewConstraintTypeCenter:
            viewAttributes = @[
                self.view.mas_centerX, self.view.mas_centerY
            ];
            break;
    }
    
    for (MASViewAttribute *viewAttribute in viewAttributes) {
        MASViewConstraint *child = [[MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
        child.delegate = self;
        [self.currentChildConstraints addObject:child];
    }
}

#pragma mark - MASConstraintDelegate

- (void)addConstraint:(id<MASConstraint>)constraint {
    [self.completedChildConstraints addObject:constraint];
}

#pragma mark - NSLayoutConstraint constant proxies

- (id<MASConstraint> (^)(UIEdgeInsets))insets {
    return ^id(UIEdgeInsets insets) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.insets(insets);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGFloat))offset {
    return ^id(CGFloat offset) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.offset(offset);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.sizeOffset(offset);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.centerOffset(offset);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (id<MASConstraint> (^)(CGFloat))percent {
    return ^id(CGFloat percent) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.percent(percent);
        }
        return self;
    };
}

#pragma mark - MASLayoutPriority proxies

- (id<MASConstraint> (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

- (id<MASConstraint> (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (id<MASConstraint> (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (id<MASConstraint> (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutRelation proxies

- (id<MASConstraint> (^)(id))relationWithBlock:(id<MASConstraint> (^)(id<MASConstraint> constraint, id attr))block {
    return ^id(id attr) {
        if (!self.added) {
            [self.delegate addConstraint:self];
            self.added = YES;
        }
        for (id<MASConstraint> constraint in self.currentChildConstraints) {
            block(constraint, attr);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(id))equalTo {
    return [self relationWithBlock:^id(id<MASConstraint> constraint, id attr) {
        return constraint.equalTo(attr);
    }];
}

- (id<MASConstraint> (^)(id))greaterThanOrEqualTo {
    return [self relationWithBlock:^id<MASConstraint>(id<MASConstraint> constraint, id attr) {
        return constraint.greaterThanOrEqualTo(attr);
    }];
}

- (id<MASConstraint> (^)(id))lessThanOrEqualTo {
    return [self relationWithBlock:^id<MASConstraint>(id<MASConstraint> constraint, id attr) {
        return constraint.lessThanOrEqualTo(attr);
    }];
}

#pragma mark - Semantic properties

- (id<MASConstraint>)with {
    return self;
}

#pragma mark - MASConstraint

- (void)commit {
    for (id<MASConstraint> constraint in self.completedChildConstraints) {
        [constraint commit];
    }
    [self.completedChildConstraints removeAllObjects];
}

@end
