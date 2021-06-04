//
//  MASConstraintMaker.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASConstraint.h"
#import "MASUtilities.h"

typedef NS_OPTIONS(NSInteger, MASAttribute) {
    MASAttributeLeft = 1 << NSLayoutAttributeLeft,
    MASAttributeRight = 1 << NSLayoutAttributeRight,
    MASAttributeTop = 1 << NSLayoutAttributeTop,
    MASAttributeBottom = 1 << NSLayoutAttributeBottom,
    MASAttributeLeading = 1 << NSLayoutAttributeLeading,
    MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    MASAttributeWidth = 1 << NSLayoutAttributeWidth,
    MASAttributeHeight = 1 << NSLayoutAttributeHeight,
    MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,

    MASAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    MASAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,

    MASAttributeBaseline = MASAttributeLastBaseline,
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    MASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    MASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    MASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    MASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    MASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    MASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    MASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    MASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

NS_ASSUME_NONNULL_BEGIN

@protocol MASLayoutConstraint <NSObject>

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

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *edges;

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *size;

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *center;

@end

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface MASConstraintMaker : NSObject <MASLayoutConstraint>

/**
 *	The following properties return a new MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MASViewAttribute
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
 *  Returns a block which creates a new MASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  MASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, readonly) MASConstraint * (^attributes)(MASAttribute attrs);

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *edges;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *size;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, readonly) MASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any MASConstraint are created with this view as the first item
 *
 *	@return	a new MASConstraintMaker
 */
- (id)initWithView:(MAS_VIEW *)view;

- (id)initWithLayoutGuide:(MASLayoutGuide *)layoutGuide API_AVAILABLE(macos(10.11), ios(9.0));

/**
 *	Calls install method on any MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MASConstraints
 */
- (NSArray *)install;

@property (nonatomic, copy, readonly) MASConstraint * (^group)(dispatch_block_t);

@end

NS_ASSUME_NONNULL_END
