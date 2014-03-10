//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import "MASViewConstraint.h"
#import "MASArrangeConstraint.h"
#import "MASArrangeConstraintMaker.h"


@interface MASArrangeConstraint ()
@property(nonatomic, strong) NSArray *views;
@property(nonatomic, retain) NSMutableArray *constraints;
@property(nonatomic) BOOL isVertical;
@property(nonatomic, strong) NSNumber * constant;
@end

@implementation MASArrangeConstraint {
}


- (id)initWith:(NSArray *)array {
    self = [super init];

    self.views = array;
    self.constraints = [NSMutableArray array];

    return self;
}


- (void)install {
    NSLayoutAttribute attribute = self.isVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeft;
    NSLayoutAttribute compoundAttribute = self.isVertical ? NSLayoutAttributeBottom : NSLayoutAttributeRight;

    MAS_VIEW* superview = ((MAS_VIEW *) self.views.firstObject).superview;
    MASViewAttribute *secondViewAttribute = [[MASViewAttribute alloc] initWithView:superview layoutAttribute:attribute];


    for (MAS_VIEW *uiView in self.views) {
        uiView.translatesAutoresizingMaskIntoConstraints = NO;
        MASViewAttribute *firstViewAttribute = [[MASViewAttribute alloc] initWithView:uiView layoutAttribute:attribute];
        MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:firstViewAttribute andSecond:secondViewAttribute];
        constraint.offset(self.constant.floatValue);
        constraint.delegate = self;
        [self.constraints addObject:constraint];

        // assign next one
        secondViewAttribute = [[MASViewAttribute alloc] initWithView:uiView layoutAttribute:compoundAttribute];
    }

    for (MASViewConstraint *viewConstraint in self.constraints) {
        [viewConstraint install];
    }
}

- (MASArrangeConstraint *)vertically {
    self.isVertical = YES;
    return self;
}

- (MASArrangeConstraint *)horizontally {
    self.isVertical = NO;
    return self;
}


- (MASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        NSAssert([attribute isKindOfClass:[NSNumber class]], @"Only NSNumber is accepted here");
        self.constant = attribute;
        return self;
    };
}


#pragma mark - MASConstraintDelegate

- (void)constraint:(MASConstraint *)constraint shouldBeReplacedWithConstraint:(MASConstraint *)replacementConstraint {
//    NSUInteger index = [self.constraints indexOfObject:constraint];
//    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
//    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];

    NSAssert(FALSE, @"Not implemented");
}

@end