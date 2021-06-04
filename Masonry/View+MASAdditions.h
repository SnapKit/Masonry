//
//  View+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASUtilities.h"
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (MASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, readonly) MASViewAttribute *mas_left;
@property (nonatomic, readonly) MASViewAttribute *mas_top;
@property (nonatomic, readonly) MASViewAttribute *mas_right;
@property (nonatomic, readonly) MASViewAttribute *mas_bottom;
@property (nonatomic, readonly) MASViewAttribute *mas_leading;
@property (nonatomic, readonly) MASViewAttribute *mas_trailing;
@property (nonatomic, readonly) MASViewAttribute *mas_width;
@property (nonatomic, readonly) MASViewAttribute *mas_height;
@property (nonatomic, readonly) MASViewAttribute *mas_centerX;
@property (nonatomic, readonly) MASViewAttribute *mas_centerY;
@property (nonatomic, readonly) MASViewAttribute *mas_baseline;

@property (nonatomic, copy, readonly) MASViewAttribute * (^mas_attribute)(NSLayoutAttribute attr);

@property (nonatomic, readonly) MASViewAttribute *mas_firstBaseline;
@property (nonatomic, readonly) MASViewAttribute *mas_lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, readonly) MASViewAttribute *mas_leftMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_rightMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_topMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_bottomMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_leadingMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_trailingMargin;
@property (nonatomic, readonly) MASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, readonly) MASViewAttribute *mas_centerYWithinMargins;

@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuide API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideLeading API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideTrailing API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideWidth API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideHeight API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideCenterX API_AVAILABLE(ios(11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_safeAreaLayoutGuideCenterY API_AVAILABLE(ios(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic) id mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (__kindof MAS_VIEW *)mas_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void (NS_NOESCAPE^)(MASConstraintMaker *make))block;

@end

NS_ASSUME_NONNULL_END
