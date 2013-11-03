//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASUtilities.h"

@protocol MASConstraintDelegate;

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (MASViewConstraint) 
 *  or a group of NSLayoutConstraints (MASComposisteConstraint)
 */
@protocol MASConstraint <NSObject>

/**
 *	Usually MASConstraintMaker but could be a parent MASConstraint
 */
@property (nonatomic, weak) id<MASConstraintDelegate> delegate;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following 
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^insets)(MASEdgeInsets insets);

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^sizeOffset)(CGSize offset);

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^centerOffset)(CGPoint offset);


/**
 *	Modifies the NSLayoutConstraint constant
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^offset)(CGFloat offset);

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^multipliedBy)(CGFloat multiplier);

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^dividedBy)(CGFloat divider);

/**
 *	Sets the NSLayoutConstraint priority to a float or MASLayoutPriority
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^priority)(MASLayoutPriority priority);

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityLow
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityLow)();

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityMedium
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityMedium)();

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityHigh
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^priorityHigh)();

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSNumber, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^equalTo)(id attr);

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSNumber, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^greaterThanOrEqualTo)(id attr);

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSNumber, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^lessThanOrEqualTo)(id attr);

/**
 *	optional semantic property which has no effect but improves the readability of constraint
 */
@property (nonatomic, copy, readonly) id<MASConstraint> with;

/**
 *	Sets the constraint debug name
 */
@property (nonatomic, copy, readonly) id<MASConstraint> (^key)(id key);

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Creates a NSLayoutConstraint. The constraint is installed to the first view or the or the closest common superview of the first and second view. 
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end

@protocol MASConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example 
 *  A MASViewConstraint may turn into a MASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(id<MASConstraint>)constraint shouldBeReplacedWithConstraint:(id<MASConstraint>)replacementConstraint;

@end
