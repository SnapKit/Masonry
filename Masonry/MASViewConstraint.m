//
//  MASConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewConstraint.h"

@interface MASViewConstraint ()

@property (nonatomic, strong, readwrite) MASViewAttribute *secondViewAttribute;
@property (nonatomic, strong) NSLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) UILayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;

@end

@implementation MASViewConstraint

- (id)initWithFirstViewAttribute:(MASViewAttribute *)firstViewAttribute {
    self = [super init];
    if (!self) return nil;
    
    _firstViewAttribute = firstViewAttribute;
    self.layoutPriority = UILayoutPriorityRequired;
    self.layoutMultiplier = 1;
    
    return self;
}

#pragma mark - private

- (void)setLayoutConstant:(CGFloat)layoutConstant {
    _layoutConstant = layoutConstant;
    self.layoutConstraint.constant = layoutConstant;
}

- (void)setLayoutRelation:(NSLayoutRelation)layoutRelation {
    _layoutRelation = layoutRelation;
    self.hasLayoutRelation = YES;
}

- (BOOL)hasBeenCommitted {
    return self.layoutConstraint != nil;
}

- (instancetype)cloneIfNeeded {
    if (self.hasLayoutRelation) {
        MASViewAttribute *firstViewAttribute = [[MASViewAttribute alloc] initWithView:self.firstViewAttribute.view layoutAttribute:self.firstViewAttribute.layoutAttribute];
        
        MASViewConstraint *viewConstraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:firstViewAttribute];
        viewConstraint.delegate = self.delegate;
        viewConstraint.layoutRelation = self.layoutRelation;
        return viewConstraint;
    }
    return self;
}

#pragma mark - layout constant

- (id<MASConstraint> (^)(UIEdgeInsets))insets {
    return ^id(UIEdgeInsets insets){
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
        return self;
    };
}

- (id<MASConstraint> (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
        switch (layoutAttribute) {
            case NSLayoutAttributeWidth:
                self.layoutConstant = offset.width;
                break;
            case NSLayoutAttributeHeight:
                self.layoutConstant = offset.height;
                break;
            default:
                break;
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
        switch (layoutAttribute) {
            case NSLayoutAttributeCenterX:
                self.layoutConstant = offset.x;
                break;
            case NSLayoutAttributeCenterY:
                self.layoutConstant = offset.y;
                break;
            default:
                break;
        }
        return self;
    };
}

- (id<MASConstraint> (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.layoutConstant = offset;
        return self;
    };
}

#pragma mark - layout multiplier

- (id<MASConstraint> (^)(CGFloat))percent {
    return ^id(CGFloat percent) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint percent after it has been committed");
        
        self.layoutMultiplier = percent;
        return self;
    };
}

#pragma mark - layout priority

- (id<MASConstraint> (^)(UILayoutPriority))priority {
    return ^id(UILayoutPriority priority) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint priority after it has been committed");
        
        self.layoutPriority = priority;
        return self;
    };
}

#pragma mark - layout relation

- (void)setSecondViewAttribute:(id)secondViewAttribute {
    if ([secondViewAttribute isKindOfClass:NSNumber.class]) {
        self.layoutConstant = [secondViewAttribute doubleValue];
    } else if ([secondViewAttribute isKindOfClass:NSArray.class]) {
        //TODO Composite
    } else if ([secondViewAttribute isKindOfClass:UIView.class]) {
        _secondViewAttribute = [[MASViewAttribute alloc] initWithView:secondViewAttribute layoutAttribute:self.firstViewAttribute.layoutAttribute];
    } else if ([secondViewAttribute isKindOfClass:MASViewAttribute.class]) {
        _secondViewAttribute = secondViewAttribute;
    } else {
        NSAssert(YES, @"attempting to add unsupported attribute: %@", secondViewAttribute);
    }
    [self.delegate addConstraint:self];
}

- (id<MASConstraint> (^)(id))equal {
    return ^id(id attr) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint equal relation after it has been committed");
        
        MASViewConstraint *viewConstraint = [self cloneIfNeeded];
        viewConstraint.layoutRelation = NSLayoutRelationEqual;
        viewConstraint.secondViewAttribute = attr;
        return viewConstraint;
    };
}

- (id<MASConstraint> (^)(id))greaterThanOrEqual {
    return ^id(id attr) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint greaterThanOrEqual relation after it has been committed");
        
        MASViewConstraint *viewConstraint = [self cloneIfNeeded];
        viewConstraint.layoutRelation = NSLayoutRelationGreaterThanOrEqual;
        viewConstraint.secondViewAttribute = attr;
        return viewConstraint;
    };
}

- (id<MASConstraint> (^)(id))lessThanOrEqual {
    return ^id(id attr) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint lessThanOrEqual relation after it has been committed");
        
        MASViewConstraint *viewConstraint = [self cloneIfNeeded];
        viewConstraint.layoutRelation = NSLayoutRelationLessThanOrEqual;
        viewConstraint.secondViewAttribute = attr;
        return viewConstraint;
    };
}

#pragma mark - MASConstraint

- (void)commit {
    NSAssert(!self.hasBeenCommitted, @"Cannot commit constraint more than once");
    
    UIView *firstLayoutItem = self.firstViewAttribute.view;
    NSLayoutAttribute firstLayoutAttribute = self.firstViewAttribute.layoutAttribute;
    UIView *secondLayoutItem = self.secondViewAttribute.view;
    NSLayoutAttribute secondLayoutAttribute = self.secondViewAttribute.layoutAttribute;
    if (self.firstViewAttribute.isAlignment && !self.secondViewAttribute) {
        secondLayoutItem = firstLayoutItem.superview;
        secondLayoutAttribute = firstLayoutAttribute;
    }
    
    
    self.layoutConstraint = [NSLayoutConstraint constraintWithItem:firstLayoutItem
                                                         attribute:firstLayoutAttribute
                                                         relatedBy:self.layoutRelation
                                                            toItem:secondLayoutItem
                                                         attribute:secondLayoutAttribute
                                                        multiplier:self.layoutMultiplier
                                                          constant:self.layoutConstant];
    
    self.layoutConstraint.priority = self.layoutPriority;
    
    if (secondLayoutItem) {
        UIView *closestCommonSuperview = nil;
        
        UIView *secondViewSuperview = secondLayoutItem;
        while (!closestCommonSuperview && secondViewSuperview) {
            UIView *firstViewSuperview = firstLayoutItem;
            while (!closestCommonSuperview && firstViewSuperview) {
                if (secondViewSuperview == firstViewSuperview) {
                    closestCommonSuperview = secondViewSuperview;
                }
                firstViewSuperview = firstViewSuperview.superview;
            }
            secondViewSuperview = secondViewSuperview.superview;
        }
        NSAssert(closestCommonSuperview,
                 @"couldn't find a common superview for %@ and %@",
                 firstLayoutItem,
                 secondLayoutItem);
        [closestCommonSuperview addConstraint:self.layoutConstraint];
    } else {
        
        [firstLayoutItem addConstraint:self.layoutConstraint];
    }
    
    
}

@end
