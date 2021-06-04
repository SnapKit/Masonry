//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASUtilities.h"

@protocol MASConstraintDelegate;

NS_ASSUME_NONNULL_BEGIN

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (MASViewConstraint) 
 *  or a group of NSLayoutConstraints (MASComposisteConstraint)
 */
@interface MASConstraint : NSObject

// Chaining Support

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
@property (nonatomic, copy, readonly) MASConstraint * (^insets)(MASEdgeInsets insets);

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
@property (nonatomic, copy, readonly) MASConstraint * (^inset)(CGFloat inset);

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
@property (nonatomic, copy, readonly) MASConstraint * (^sizeOffset)(CGSize offset);

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
@property (nonatomic, copy, readonly) MASConstraint * (^centerOffset)(CGPoint offset);

/**
 *	Modifies the NSLayoutConstraint constant
 */
@property (nonatomic, copy, readonly) MASConstraint * (^offset)(CGFloat offset);

/**
 *  Modifies the NSLayoutConstraint constant based on a value type
 */
@property (nonatomic, copy, readonly) MASConstraint * (^valueOffset)(NSValue *value);

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
@property (nonatomic, copy, readonly) MASConstraint * (^multipliedBy)(CGFloat multiplier);

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
@property (nonatomic, copy, readonly) MASConstraint * (^dividedBy)(CGFloat divider);

/**
 *	Sets the NSLayoutConstraint priority to a float or MASLayoutPriority
 */
@property (nonatomic, copy, readonly) MASConstraint * (^priority)(MASLayoutPriority priority);

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityLow
 */
@property (nonatomic, copy, readonly) MASConstraint * (^priorityLow)(void);

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityMedium
 */
@property (nonatomic, copy, readonly) MASConstraint * (^priorityMedium)(void);

/**
 *	Sets the NSLayoutConstraint priority to MASLayoutPriorityHigh
 */
@property (nonatomic, copy, readonly) MASConstraint * (^priorityHigh)(void);

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) MASConstraint * (^equalTo)(id attr);

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) MASConstraint * (^greaterThanOrEqualTo)(id attr);

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
@property (nonatomic, copy, readonly) MASConstraint * (^lessThanOrEqualTo)(id attr);

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
@property (nonatomic, readonly) MASConstraint *with;

#ifndef __cplusplus
#ifndef and
/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 *  `and` is defined in <iso646.h> in C or as an operator was built into C++
 */
@property (nonatomic, readonly) MASConstraint *and;
#endif
#endif

/**
 *	Creates a new MASCompositeConstraint with the called attribute and reciever
 */
@property (nonatomic, readonly) MASConstraint *left;
@property (nonatomic, readonly) MASConstraint *top;
@property (nonatomic, readonly) MASConstraint *right;
@property (nonatomic, readonly) MASConstraint *bottom;
@property (nonatomic, readonly) MASConstraint *leading;
@property (nonatomic, readonly) MASConstraint *trailing;
@property (nonatomic, readonly) MASConstraint *width;
@property (nonatomic, readonly) MASConstraint *height;
@property (nonatomic, readonly) MASConstraint *centerX;
@property (nonatomic, readonly) MASConstraint *centerY;
@property (nonatomic, readonly) MASConstraint *baseline;

@property (nonatomic, readonly) MASConstraint *firstBaseline;
@property (nonatomic, readonly) MASConstraint *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, readonly) MASConstraint *leftMargin;
@property (nonatomic, readonly) MASConstraint *rightMargin;
@property (nonatomic, readonly) MASConstraint *topMargin;
@property (nonatomic, readonly) MASConstraint *bottomMargin;
@property (nonatomic, readonly) MASConstraint *leadingMargin;
@property (nonatomic, readonly) MASConstraint *trailingMargin;
@property (nonatomic, readonly) MASConstraint *centerXWithinMargins;
@property (nonatomic, readonly) MASConstraint *centerYWithinMargins;

#endif


/**
 *	Sets the constraint debug name
 */
@property (nonatomic, copy, readonly) MASConstraint * (^key)(id key);

// NSLayoutConstraint constant Setters
// for use outside of mas_updateConstraints/mas_makeConstraints blocks

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInsets:(MASEdgeInsets)insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInset:(CGFloat)inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (void)setSizeOffset:(CGSize)sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (void)setCenterOffset:(CGPoint)centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (void)setOffset:(CGFloat)offset;


// NSLayoutConstraint Installation support

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
/**
 *  Whether or not to go through the animator proxy when modifying the constraint
 */
@property (nonatomic, copy, readonly) MASConstraint *animator;
#endif

/**
 *    Usually MASConstraintMaker but could be a parent MASConstraint
 */
@property (nonatomic, weak) id<MASConstraintDelegate> delegate;

/**
 *  Activates an NSLayoutConstraint if it's supported by an OS. 
 *  Invokes install otherwise.
 */
- (void)activate;

/**
 *  Deactivates previously installed/activated NSLayoutConstraint.
 */
- (void)deactivate;

/**
 *	Creates a NSLayoutConstraint and adds it to the appropriate view.
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end


/**
 *  Convenience auto-boxing macros for MASConstraint methods.
 *
 *  Defining MAS_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define mas_equalTo(...)                 equalTo(MASBoxValue((__VA_ARGS__)))
#define mas_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
#define mas_lessThanOrEqualTo(...)       lessThanOrEqualTo(MASBoxValue((__VA_ARGS__)))

#define mas_offset(...)                  valueOffset(MASBoxValue((__VA_ARGS__)))


#ifdef MAS_SHORTHAND_GLOBALS

#define equalTo(...)                     mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           mas_lessThanOrEqualTo(__VA_ARGS__)

#define offset(...)                      mas_offset(__VA_ARGS__)

#endif


@interface MASConstraint (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
@property (nonatomic, copy, readonly) MASConstraint * (^mas_equalTo)(id attr);
@property (nonatomic, copy, readonly) MASConstraint * (^mas_greaterThanOrEqualTo)(id attr);
@property (nonatomic, copy, readonly) MASConstraint * (^mas_lessThanOrEqualTo)(id attr);

/**
 *  A dummy method to aid autocompletion
 */
@property (nonatomic, copy, readonly) MASConstraint * (^mas_offset)(id offset);

@end


@protocol MASConstraintDelegate <NSObject>

/**
 *    Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A MASViewConstraint may turn into a MASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(MASConstraint *)constraint shouldBeReplacedWithConstraint:(MASConstraint *)replacementConstraint;

- (MASConstraint *)constraint:(MASConstraint * _Nullable)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end

NS_ASSUME_NONNULL_END
