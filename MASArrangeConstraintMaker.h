//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MASConstraintMaker.h"

@class MASArrangeConstraint;


@interface MASArrangeConstraintMaker : MASConstraintMaker

@property (nonatomic, strong, readonly) MASArrangeConstraint *arrange;
@property(nonatomic, retain) NSArray *viewsToArrange;

- (id)initWithViews:(NSArray *)views;

@end