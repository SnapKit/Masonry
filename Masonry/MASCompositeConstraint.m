//
//  MASCompositeConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASCompositeConstraint.h"

@interface MASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) id mas_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation MASCompositeConstraint

@synthesize delegate = _delegate;
@synthesize updateExisting = _updateExisting;

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;

    _childConstraints = [children mutableCopy];
    for (id<MASConstraint> constraint in _childConstraints) {
        constraint.delegate = self;
    }

    return self;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(id<MASConstraint>)constraint shouldBeReplacedWithConstraint:(id<MASConstraint>)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

#pragma mark - NSLayoutConstraint constant proxies

- (id<MASConstraint> (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.insets(insets);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGFloat))offset {
    return ^id(CGFloat offset) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.offset(offset);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.sizeOffset(offset);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.centerOffset(offset);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (id<MASConstraint> (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

#pragma mark - MASLayoutPriority proxies

- (id<MASConstraint> (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        for (id<MASConstraint> constraint in self.childConstraints) {
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

- (id<MASConstraint> (^)(id))equalTo {
    return ^id(id attr) {
        for (id<MASConstraint> constraint in self.childConstraints.copy) {
            constraint.equalTo(attr);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(id))greaterThanOrEqualTo {
    return ^id(id attr) {
        for (id<MASConstraint> constraint in self.childConstraints.copy) {
            constraint.greaterThanOrEqualTo(attr);
        }
        return self;
    };
}

- (id<MASConstraint> (^)(id))lessThanOrEqualTo {
    return ^id(id attr) {
        for (id<MASConstraint> constraint in self.childConstraints.copy) {
            constraint.lessThanOrEqualTo(attr);
        }
        return self;
    };
}

#pragma mark - Semantic properties

- (id<MASConstraint>)with {
    return self;
}

#pragma mark - debug helpers

- (id<MASConstraint> (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        int i = 0;
        for (id<MASConstraint> constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

#pragma mark - MASConstraint

- (void)install {
    for (id<MASConstraint> constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (id<MASConstraint> constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end
