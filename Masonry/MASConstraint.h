//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    MASLayoutPriorityRequired = UILayoutPriorityRequired,
    MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh,
    MASLayoutPriorityDefaultMedium = 500,
    MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow,
    MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel,
};
typedef float MASLayoutPriority;

@protocol MASConstraint <NSObject>

//layout constants
@property (nonatomic, copy, readonly) id<MASConstraint> (^insets)(UIEdgeInsets insets);
@property (nonatomic, copy, readonly) id<MASConstraint> (^sizeOffset)(CGSize offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^centerOffset)(CGPoint offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^offset)(CGFloat offset);

//layout multipliers
@property (nonatomic, copy, readonly) id<MASConstraint> (^percent)(CGFloat percent);

//layout priority
@property (nonatomic, copy, readonly) id<MASConstraint> (^priority)(UILayoutPriority priority);
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityLow)();
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityMedium)();
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityHigh)();

//layout relation
@property (nonatomic, copy, readonly) id<MASConstraint> (^equalTo)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^greaterThanOrEqualTo)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^lessThanOrEqualTo)(id attr);

//semantic properties
@property (nonatomic, copy, readonly) id<MASConstraint> with;

- (void)commit;

@end

@protocol MASConstraintDelegate <NSObject>

- (void)addConstraint:(id<MASConstraint>)constraint;

@end