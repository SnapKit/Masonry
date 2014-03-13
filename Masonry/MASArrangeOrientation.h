//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MASViewConstraint.h"

@class MASArrangeConstraint;


@interface MASArrangeOrientation : NSObject

- (id)initWith:(NSArray *)array;

@property (nonatomic, strong, readonly) MASArrangeConstraint *vertically;
@property (nonatomic, strong, readonly) MASArrangeConstraint *horizontally;

@end