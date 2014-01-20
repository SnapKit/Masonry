//
//  MASConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"
#import "MASCompositeConstraint.h"
#import "MASLayoutConstraint.h"
#import "View+MASAdditions.h"

@interface MASViewConstraint ()

@property (nonatomic, strong, readwrite) MASViewAttribute *secondViewAttribute;
@property (nonatomic, weak) MAS_VIEW *installedView;
@property (nonatomic, weak) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;
@property (nonatomic, strong) id mas_key;
@property (nonatomic, assign) BOOL useAnimator;

@end

@implementation MASViewConstraint

- (id)initWithFirstViewAttribute:(MASViewAttribute *)firstViewAttribute {
    self = [super init];
    if (!self) return nil;
    
    _firstViewAttribute = firstViewAttribute;
    self.layoutPriority = MASLayoutPriorityRequired;
    self.layoutMultiplier = 1;
    
    return self;
}

#pragma mark - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:self.firstViewAttribute];
    constraint.layoutConstant = self.layoutConstant;
    constraint.layoutRelation = self.layoutRelation;
    constraint.layoutPriority = self.layoutPriority;
    constraint.layoutMultiplier = self.layoutMultiplier;
    constraint.delegate = self.delegate;
    return constraint;
}

#pragma mark - private

- (void)setLayoutConstant:(CGFloat)layoutConstant {
    _layoutConstant = layoutConstant;

#if TARGET_OS_MAC && !TARGET_OS_IPHONE
    if(self.useAnimator) {
        self.layoutConstraint.animator.constant = layoutConstant;
    } else {
        self.layoutConstraint.constant = layoutConstant;
    }
#else
    self.layoutConstraint.constant = layoutConstant;
#endif
}

- (void)setLayoutRelation:(NSLayoutRelation)layoutRelation {
    _layoutRelation = layoutRelation;
    self.hasLayoutRelation = YES;
}

- (BOOL)hasBeenInstalled {
    return self.layoutConstraint != nil;
}

- (void)setSecondViewAttribute:(id)secondViewAttribute {
    if ([secondViewAttribute isKindOfClass:NSNumber.class]) {
        self.layoutConstant = [secondViewAttribute doubleValue];
    }  else if ([secondViewAttribute isKindOfClass:MAS_VIEW.class]) {
        _secondViewAttribute = [[MASViewAttribute alloc] initWithView:secondViewAttribute layoutAttribute:self.firstViewAttribute.layoutAttribute];
    } else if ([secondViewAttribute isKindOfClass:MASViewAttribute.class]) {
        _secondViewAttribute = secondViewAttribute;
    } else {
        NSAssert(NO, @"attempting to add unsupported attribute: %@", secondViewAttribute);
    }
}

#pragma mark - NSLayoutConstraint constant proxies

- (MASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (MASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (MASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (MASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

#pragma mark - NSLayoutConstraint multiplier proxies

- (MASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint multiplier after it has been installed");
        
        self.layoutMultiplier = multiplier;
        return self;
    };
}


- (MASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint multiplier after it has been installed");

        self.layoutMultiplier = 1.0/divider;
        return self;
    };
}

#pragma mark - MASLayoutPriority proxies

- (MASConstraint * (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        NSAssert(!self.hasBeenInstalled,
                 @"Cannot modify constraint priority after it has been installed");
        
        self.layoutPriority = priority;
        return self;
    };
}

- (MASConstraint * (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (MASConstraint * (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (MASConstraint * (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutRelation proxies

- (MASConstraint * (^)(id))equalityWithRelation:(NSLayoutRelation)relation {
    return ^id(id attribute) {
        if ([attribute isKindOfClass:NSArray.class]) {
            NSAssert(!self.hasLayoutRelation, @"Redefinition of constraint relation");
            NSMutableArray *children = NSMutableArray.new;
            for (id attr in attribute) {
                MASViewConstraint *viewConstraint = [self copy];
                viewConstraint.secondViewAttribute = attr;
                [children addObject:viewConstraint];
            }
            MASCompositeConstraint *compositeConstraint = [[MASCompositeConstraint alloc] initWithChildren:children];
            compositeConstraint.delegate = self.delegate;
            [self.delegate constraint:self shouldBeReplacedWithConstraint:compositeConstraint];
            return compositeConstraint;
        } else {
            BOOL layoutConstantUpdate = self.layoutRelation == relation && [attribute isKindOfClass:NSNumber.class];
            NSAssert(!self.hasLayoutRelation || layoutConstantUpdate, @"Redefinition of constraint relation");
            self.layoutRelation = relation;
            self.secondViewAttribute = attribute;
            return self;
        }
    };
}

- (MASConstraint * (^)(id))equalTo {
    return [self equalityWithRelation:NSLayoutRelationEqual];
}

- (MASConstraint * (^)(id))greaterThanOrEqualTo {
    return [self equalityWithRelation:NSLayoutRelationGreaterThanOrEqual];
}

- (MASConstraint * (^)(id))lessThanOrEqualTo {
    return [self equalityWithRelation:NSLayoutRelationLessThanOrEqual];
}

#pragma mark - Semantic properties

- (MASConstraint *)with {
    return self;
}

#pragma mark - Animator proxy

#if TARGET_OS_MAC && !TARGET_OS_IPHONE

- (MASConstraint *)animator {
    self.useAnimator = YES;
    return self;
}

#endif

#pragma mark - debug helpers

- (MASConstraint * (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setters

- (void)setInsets:(MASEdgeInsets)insets {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeLeft:
            self.layoutConstant = insets.left;
            break;
        case NSLayoutAttributeTop:
            self.layoutConstant = insets.top;
            break;
        case NSLayoutAttributeBottom:
            self.layoutConstant = -insets.bottom;
            break;
        case NSLayoutAttributeRight:
            self.layoutConstant = -insets.right;
            break;
        default:
            break;
    }
}

- (void)setOffset:(CGFloat)offset {
    self.layoutConstant = offset;
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeWidth:
            self.layoutConstant = sizeOffset.width;
            break;
        case NSLayoutAttributeHeight:
            self.layoutConstant = sizeOffset.height;
            break;
        default:
            break;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeCenterX:
            self.layoutConstant = centerOffset.x;
            break;
        case NSLayoutAttributeCenterY:
            self.layoutConstant = centerOffset.y;
            break;
        default:
            break;
    }
}

#pragma mark - MASConstraint

- (void)install {
    NSAssert(!self.hasBeenInstalled, @"Cannot install constraint more than once");
    
    MAS_VIEW *firstLayoutItem = self.firstViewAttribute.view;
    NSLayoutAttribute firstLayoutAttribute = self.firstViewAttribute.layoutAttribute;
    MAS_VIEW *secondLayoutItem = self.secondViewAttribute.view;
    NSLayoutAttribute secondLayoutAttribute = self.secondViewAttribute.layoutAttribute;

    // alignment attributes must have a secondViewAttribute
    // therefore we assume that is refering to superview
    // eg make.left.equalTo(@10)
    if (!self.firstViewAttribute.isSizeAttribute && !self.secondViewAttribute) {
        secondLayoutItem = firstLayoutItem.superview;
        secondLayoutAttribute = firstLayoutAttribute;
    }
    
    MASLayoutConstraint *layoutConstraint
        = [MASLayoutConstraint constraintWithItem:firstLayoutItem
                                        attribute:firstLayoutAttribute
                                        relatedBy:self.layoutRelation
                                           toItem:secondLayoutItem
                                        attribute:secondLayoutAttribute
                                       multiplier:self.layoutMultiplier
                                         constant:self.layoutConstant];
    
    layoutConstraint.priority = self.layoutPriority;
    layoutConstraint.mas_key = self.mas_key;
    
    if (secondLayoutItem) {
        MAS_VIEW *closestCommonSuperview = [firstLayoutItem mas_closestCommonSuperview:secondLayoutItem];
        NSAssert(closestCommonSuperview,
                 @"couldn't find a common superview for %@ and %@",
                 firstLayoutItem, secondLayoutItem);
        self.installedView = closestCommonSuperview;
    } else {
        self.installedView = firstLayoutItem;
    }


    MASLayoutConstraint *existingConstraint = nil;
    if (self.updateExisting) {
        existingConstraint = [self layoutConstraintSimiliarTo:layoutConstraint];
    }
    if (existingConstraint) {
        // just update the constant
        existingConstraint.constant = layoutConstraint.constant;
        self.layoutConstraint = existingConstraint;
    } else {
        [self.installedView addConstraint:layoutConstraint];
        self.layoutConstraint = layoutConstraint;
    }
}

- (MASLayoutConstraint *)layoutConstraintSimiliarTo:(MASLayoutConstraint *)layoutConstraint {
    // check if any constraints are the same apart from the only mutable property constant

    // go through constraints in reverse as we do not want to match auto-resizing or interface builder constraints
    // and they are likely to be added first.
    for (NSLayoutConstraint *existingConstraint in self.installedView.constraints.reverseObjectEnumerator) {
        if (![existingConstraint isKindOfClass:MASLayoutConstraint.class]) continue;
        if (existingConstraint.firstItem != layoutConstraint.firstItem) continue;
        if (existingConstraint.secondItem != layoutConstraint.secondItem) continue;
        if (existingConstraint.firstAttribute != layoutConstraint.firstAttribute) continue;
        if (existingConstraint.secondAttribute != layoutConstraint.secondAttribute) continue;
        if (existingConstraint.multiplier != layoutConstraint.multiplier) continue;
        if (existingConstraint.priority != layoutConstraint.priority) continue;

        return (id)existingConstraint;
    }
    return nil;
}

- (void)uninstall {
    [self.installedView removeConstraint:self.layoutConstraint];
    self.layoutConstraint = nil;
    self.installedView = nil;
}

@end
