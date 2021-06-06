//
//  MASConstraintDelegate.m
//  Masonry
//
//  Created by Jonas Budelmann on 28/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASConstraintDelegateMock.h"

@implementation MASConstraintDelegateMock

- (instancetype)init {
    if (self = [super init]) {
        self.constraints = NSMutableArray.new;
        self.chainedConstraints = NSMutableArray.new;
    }

    return self;
}

- (void)constraint:(MASConstraint *)constraint shouldBeReplacedWithConstraint:(MASConstraint *)replacementConstraint {
    [self.constraints replaceObjectAtIndex:[self.constraints indexOfObject:constraint] withObject:replacementConstraint];
}

- (id)constraint:(MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self.chainedConstraints addObject:constraint];
    
    MASViewConstraint *viewConstraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:[[MASViewAttribute alloc] initWithView:nil layoutAttribute:layoutAttribute]];
    return viewConstraint;
}

@end
