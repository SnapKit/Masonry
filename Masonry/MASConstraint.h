//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MASConstraint <NSObject>

@property (nonatomic, copy, readonly) id<MASConstraint> (^insets)(UIEdgeInsets insets);
@property (nonatomic, copy, readonly) id<MASConstraint> (^sizeOffset)(CGSize offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^centerOffset)(CGPoint offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^offset)(CGFloat offset);
@property (nonatomic, copy, readonly) id<MASConstraint> (^percent)(CGFloat percent);
@property (nonatomic, copy, readonly) id<MASConstraint> (^priority)(UILayoutPriority priority);
@property (nonatomic, copy, readonly) id<MASConstraint> (^equal)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^greaterThanOrEqual)(id attr);
@property (nonatomic, copy, readonly) id<MASConstraint> (^lessThanOrEqual)(id attr);

- (void)commit;

@end

@protocol MASConstraintDelegate <NSObject>

- (void)addConstraint:(id<MASConstraint>)constraint;

@end