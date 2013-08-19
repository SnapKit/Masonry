//
//  MASConstraintBuilder.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASConstraintMaker.h"
#import "MASViewConstraint.h"
#import "MASCompositeConstraint.h"
#import "MASViewAttribute.h"

@interface MASConstraintMaker () <MASConstraintDelegate>

@property (nonatomic, weak) MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation MASConstraintMaker

- (id)initWithView:(MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (void)commit {
    for (id<MASConstraint> constraint in self.constraints) {
        [constraint install];
    }
    [self.constraints removeAllObjects];
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(id<MASConstraint>)constraint shouldBeReplacedWithConstraint:(id<MASConstraint>)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

#pragma mark - constraint properties

- (id<MASConstraint>)constraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    MASViewAttribute *viewAttribute = [[MASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (id<MASConstraint>)left {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (id<MASConstraint>)top {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (id<MASConstraint>)right {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (id<MASConstraint>)bottom {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (id<MASConstraint>)leading {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (id<MASConstraint>)trailing {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (id<MASConstraint>)width {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (id<MASConstraint>)height {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (id<MASConstraint>)centerX {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (id<MASConstraint>)centerY {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (id<MASConstraint>)baseline {
    return [self constraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}


#pragma mark - composite Attributes

- (id<MASConstraint>)edges {
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithView:self.view type:MASCompositeConstraintTypeEdges];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

- (id<MASConstraint>)size {
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithView:self.view type:MASCompositeConstraintTypeSize];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

- (id<MASConstraint>)center {
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithView:self.view type:MASCompositeConstraintTypeCenter];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}
@end
