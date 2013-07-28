//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    MASLayoutPriorityRequired = UILayoutPriorityRequired,
    MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh,
    MASLayoutPriorityDefaultMedium = 500,
    MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow,
    MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel,
};
typedef float MASLayoutPriority;

@protocol MASConstraint <NSObject>

//NSLayoutConstraint constant proxies
@property (nonatomic, copy, readonly) id<MASConstraint> (^insets)(UIEdgeInsets insets);
@property (nonatomic, copy, readonly) id<MASConstraint> (^sizeOffset)(CGSize offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^centerOffset)(CGPoint offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^offset)(CGFloat offset);

//NSLayoutConstraint multiplier proxies
@property (nonatomic, copy, readonly) id<MASConstraint> (^percent)(CGFloat percent);

//MASLayoutPriority proxies
@property (nonatomic, copy, readonly) id<MASConstraint> (^priority)(MASLayoutPriority priority);
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityLow)();
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityMedium)();
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityHigh)();

//NSLayoutRelation proxies
@property (nonatomic, copy, readonly) id<MASConstraint> (^equalTo)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^greaterThanOrEqualTo)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^lessThanOrEqualTo)(id attr);

//semantic properties
@property (nonatomic, copy, readonly) id<MASConstraint> with;

/**
 Creates a NSLayoutConstraint. The constraint is added to the first view or the or the closest common superview of the first and second view. 
 */
- (void)commit;

@end

@protocol MASConstraintDelegate <NSObject>

/**
 Notifies the delegate when the constraint is has the minimum set of properties, has a NSLayoutRelation and view
 */
- (void)addConstraint:(id<MASConstraint>)constraint;

@end