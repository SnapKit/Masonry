//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MASConstraintMaker.h"
#import "MASArrangeConstraint.h"

@interface MASArrangeConstraintMaker : MASConstraintMaker

@property (nonatomic, strong, readonly) MASArrangeConstraint *arrange;
@property (nonatomic, strong, readonly) MASArrangeConstraint *each;

@property(nonatomic, retain) NSArray *viewsToArrange;

- (id)initWithViews:(NSArray *)views;

@end