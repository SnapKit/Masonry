//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import <Masonry/MASViewConstraint.h>
#import <Masonry/View+MASAdditions.h>
#import "MASArrangeConstraintMaker.h"
#import "MASArrangeConstraint.h"
#import "MASArrangeOrientation.h"


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

- (MASArrangeOrientation *)arrange {
    MASArrangeOrientation *constraint = [[MASArrangeOrientation alloc] initWith:self.viewsToArrange];
    [self.constraints addObject:constraint];
    return constraint;
}

- (MASConstraintMaker *)each {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Method is not implemented yet"] userInfo:nil];
}

- (NSArray *)install {
    for (MASConstraint *constraint in self.constraints) {
        [constraint install];
    }

    return self.constraints;
}


@end