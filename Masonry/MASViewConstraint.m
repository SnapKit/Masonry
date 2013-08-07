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
#import "NSObject+MASKeyAdditions.h"

@interface MASViewConstraint ()

@property (nonatomic, strong, readwrite) MASViewAttribute *secondViewAttribute;
@property (nonatomic, strong, readwrite) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign) BOOL hasLayoutRelation;

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
    self.layoutConstraint.constant = layoutConstant;
}

- (void)setLayoutRelation:(NSLayoutRelation)layoutRelation {
    _layoutRelation = layoutRelation;
    self.hasLayoutRelation = YES;
}

- (BOOL)hasBeenCommitted {
    return self.layoutConstraint != nil;
}

- (void)setSecondViewAttribute:(id)secondViewAttribute {
    if ([secondViewAttribute isKindOfClass:NSNumber.class]) {
        self.layoutConstant = [secondViewAttribute doubleValue];
    }  else if ([secondViewAttribute isKindOfClass:UIView.class]) {
        _secondViewAttribute = [[MASViewAttribute alloc] initWithView:secondViewAttribute layoutAttribute:self.firstViewAttribute.layoutAttribute];
    } else if ([secondViewAttribute isKindOfClass:MASViewAttribute.class]) {
        _secondViewAttribute = secondViewAttribute;
    } else {
        NSAssert(YES, @"attempting to add unsupported attribute: %@", secondViewAttribute);
    }
}

#pragma mark - NSLayoutConstraint constant proxies

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

#pragma mark - NSLayoutConstraint multiplier proxies

- (id<MASConstraint> (^)(CGFloat))percent {
    return ^id(CGFloat percent) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint percent after it has been committed");
        
        self.layoutMultiplier = percent;
        return self;
    };
}

#pragma mark - MASLayoutPriority proxies

- (id<MASConstraint> (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        NSAssert(!self.hasBeenCommitted,
                 @"Cannot modify constraint priority after it has been committed");
        
        self.layoutPriority = priority;
        return self;
    };
}

- (id<MASConstraint> (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (id<MASConstraint> (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (id<MASConstraint> (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutRelation proxies

- (id<MASConstraint> (^)(id))equalityWithRelation:(NSLayoutRelation)relation {
    return ^id(id attribute) {
        NSAssert(!self.hasLayoutRelation, @"Redefinition of constraint relation");
        if ([attribute isKindOfClass:NSArray.class]) {
            NSMutableArray *children = NSMutableArray.new;
            for (id attr in attribute) {
                MASViewConstraint *viewConstraint = [self copy];
                viewConstraint.secondViewAttribute = attr;
                [viewConstraint.delegate addConstraint:viewConstraint];
                [children addObject:viewConstraint];
            }
            MASCompositeConstraint *compositeConstraint = [[MASCompositeConstraint alloc] initWithView:self.firstViewAttribute.view children:children];
            compositeConstraint.delegate = self.delegate;
            return compositeConstraint;
        } else {
            self.layoutRelation = relation;
            self.secondViewAttribute = attribute;
            [self.delegate addConstraint:self];
            return self;
        }
    };
}

- (id<MASConstraint> (^)(id))equalTo {
    return [self equalityWithRelation:NSLayoutRelationEqual];
}

- (id<MASConstraint> (^)(id))greaterThanOrEqualTo {
    return [self equalityWithRelation:NSLayoutRelationGreaterThanOrEqual];
}

- (id<MASConstraint> (^)(id))lessThanOrEqualTo {
    return [self equalityWithRelation:NSLayoutRelationLessThanOrEqual];
}

#pragma mark - Semantic properties

- (id<MASConstraint>)with {
    return self;
}

#pragma mark - debug helpers

- (id<MASConstraint> (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        return self;
    };
}

#pragma mark - MASConstraint

- (void)commit {
    NSAssert(!self.hasBeenCommitted, @"Cannot commit constraint more than once");
    
    UIView *firstLayoutItem = self.firstViewAttribute.view;
    NSLayoutAttribute firstLayoutAttribute = self.firstViewAttribute.layoutAttribute;
    UIView *secondLayoutItem = self.secondViewAttribute.view;
    NSLayoutAttribute secondLayoutAttribute = self.secondViewAttribute.layoutAttribute;
    if (!self.firstViewAttribute.isSizeAttribute && !self.secondViewAttribute) {
        secondLayoutItem = firstLayoutItem.superview;
        secondLayoutAttribute = firstLayoutAttribute;
    }
    
    
    self.layoutConstraint = [MASLayoutConstraint constraintWithItem:firstLayoutItem
                                                          attribute:firstLayoutAttribute
                                                          relatedBy:self.layoutRelation
                                                             toItem:secondLayoutItem
                                                          attribute:secondLayoutAttribute
                                                         multiplier:self.layoutMultiplier
                                                           constant:self.layoutConstant];
    
    self.layoutConstraint.priority = self.layoutPriority;
    self.layoutConstraint.mas_key = self.mas_key;
    
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
