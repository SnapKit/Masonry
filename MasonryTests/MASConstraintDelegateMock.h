//
//  MASConstraintDelegate.h
//  Masonry
//
//  Created by Jonas Budelmann on 28/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASConstraint.h"

@interface MASConstraintDelegateMock : NSObject <MASConstraintDelegate>

@property (nonatomic, strong) NSMutableArray *constraints;

@end
