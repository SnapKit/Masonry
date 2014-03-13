//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MASViewConstraint.h"


@interface MASArrangeConstraint : NSObject

@property(nonatomic) BOOL isVertical;

- (id)initWith:(NSArray *)array;
- (void)install;

// Create an array of constraints using an ASCII art-like visual format string.
// views are labeled as v1, v2,...
- (MASArrangeConstraint * (^)(id))ascii;

// offset between views
- (MASArrangeConstraint * (^)(id))withOffset;

@end