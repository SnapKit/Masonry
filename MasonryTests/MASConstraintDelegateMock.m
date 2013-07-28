//
//  MASConstraintDelegate.m
//  Masonry
//
//  Created by Jonas Budelmann on 28/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASConstraintDelegateMock.h"

@implementation MASConstraintDelegateMock

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.constraints = NSMutableArray.new;

    return self;
}

- (void)addConstraint:(id<MASConstraint>)constraint {
    [self.constraints addObject:constraint];
}

@end
