//
//  MASConstraintDelegate.h
//  Masonry
//
//  Created by Jonas Budelmann on 28/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASConstraint+Private.h"

@interface MASConstraintDelegateMock : NSObject <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *constraints;
@property (nonatomic, strong) NSMutableArray *chainedConstraints;

@end
