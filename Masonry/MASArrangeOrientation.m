//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Masonry/MASArrangeConstraint.h>
#import "MASViewConstraint.h"
#import "MASArrangeOrientation.h"
#import "MASArrangeConstraintMaker.h"


@interface MASArrangeOrientation ()
@property(nonatomic, strong) NSArray *views;
@property(nonatomic, retain) NSMutableArray *constraints;
@property(nonatomic, strong) NSNumber * constant;
@end

@implementation MASArrangeOrientation {
}


- (id)initWith:(NSArray *)array {
    self = [super init];

    self.views = array;
    self.constraints = [NSMutableArray array];

    return self;
}


- (void)install {
    for (MASConstraint *constraint in self.constraints) {
        [constraint install];
    }
}

- (MASArrangeConstraint *)vertically {
    MASArrangeConstraint* c = [[MASArrangeConstraint alloc] initWith:self.views];
    c.isVertical = YES;
    [self.constraints addObject:c];
    return c;
}

- (MASArrangeConstraint *)horizontally {
    MASArrangeConstraint* c = [[MASArrangeConstraint alloc] initWith:self.views];
    c.isVertical = NO;
    [self.constraints addObject:c];
    return c;
}


@end