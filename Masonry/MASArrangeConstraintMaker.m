//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Masonry/MASViewConstraint.h>
#import "MASArrangeConstraintMaker.h"
#import "MASArrangeConstraint.h"


@interface MASArrangeConstraintMaker ()
@property(nonatomic, retain) NSMutableArray *constraints;
@end

@implementation MASArrangeConstraintMaker {

}

- (id)initWithViews:(NSArray *)views {
    self = [super init];

    self.viewsToArrange = views;
    self.constraints = NSMutableArray.new;

    return self;
}

#pragma mark - properties

- (MASArrangeConstraint *)arrange {
    MASArrangeConstraint *constraint = [[MASArrangeConstraint alloc] initWith:self.viewsToArrange];
    [self.constraints addObject:constraint];
    return constraint;
}

- (MASArrangeConstraint *)each {
    MASArrangeConstraint *constraint = [[MASArrangeConstraint alloc] initWith:self.viewsToArrange];
    [self.constraints addObject:constraint];
    return constraint;
}

- (NSArray *)install {
    for (MASArrangeConstraint *masArrangeConstraint in self.constraints) {
        [masArrangeConstraint install];
    }

    return self.constraints;
}


@end