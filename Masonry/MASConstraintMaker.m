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
#import "View+MASAdditions.h"

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

- (NSArray *)install {
    NSArray *constraints = self.constraints.copy;
    for (id<MASConstraint> constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(id<MASConstraint>)constraint shouldBeReplacedWithConstraint:(id<MASConstraint>)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

#pragma mark - constraint properties

- (id<MASConstraint>)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    MASViewAttribute *viewAttribute = [[MASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (id<MASConstraint>)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (id<MASConstraint>)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (id<MASConstraint>)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (id<MASConstraint>)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (id<MASConstraint>)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (id<MASConstraint>)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (id<MASConstraint>)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (id<MASConstraint>)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (id<MASConstraint>)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (id<MASConstraint>)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (id<MASConstraint>)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}


#pragma mark - composite Attributes

- (id<MASConstraint>)edges {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_top],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_left],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_bottom],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_right]
    ];
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

- (id<MASConstraint>)size {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_width],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_height]
    ];
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

- (id<MASConstraint>)center {
    NSArray *children = @[
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_centerX],
        [[MASViewConstraint alloc] initWithFirstViewAttribute:self.view.mas_centerY]
    ];
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}
@end
