//
//  MASConstraintBuilder.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraint.h"

@interface MASConstraintMaker : NSObject

@property (nonatomic, strong, readonly) id<MASConstraint> left;
@property (nonatomic, strong, readonly) id<MASConstraint> top;
@property (nonatomic, strong, readonly) id<MASConstraint> right;
@property (nonatomic, strong, readonly) id<MASConstraint> bottom;
@property (nonatomic, strong, readonly) id<MASConstraint> leading;
@property (nonatomic, strong, readonly) id<MASConstraint> trailing;
@property (nonatomic, strong, readonly) id<MASConstraint> width;
@property (nonatomic, strong, readonly) id<MASConstraint> height;
@property (nonatomic, strong, readonly) id<MASConstraint> centerX;
@property (nonatomic, strong, readonly) id<MASConstraint> centerY;
@property (nonatomic, strong, readonly) id<MASConstraint> baseline;

@property (nonatomic, strong, readonly) id<MASConstraint> edges;
@property (nonatomic, strong, readonly) id<MASConstraint> size;
@property (nonatomic, strong, readonly) id<MASConstraint> center;

- (id)initWithView:(UIView *)view;
- (void)commit;

@end
