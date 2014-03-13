//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



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

- (NSArray *)install {
    NSMutableArray *c = self.constraints.copy;
    for (MASArrangeConstraint *arrangeConstraint in c) {

    }


    return [super install];
}

- (void)dealloc {
    [_viewsToArrange release];
    [_constraints release];
    [super dealloc];
}


@end