//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MASConstraintMaker.h"
#import "MASArrangeConstraint.h"

@class MASArrangeOrientation;

@interface MASArrangeConstraintMaker : MASConstraintMaker

// to set an arrangement of views
@property (nonatomic, strong, readonly) MASArrangeOrientation *arrange;

//  set individual constraints here?
@property (nonatomic, strong, readonly) MASConstraintMaker *each;

// list of views
@property(nonatomic, retain) NSArray *viewsToArrange;

- (id)initWithViews:(NSArray *)views;

@end