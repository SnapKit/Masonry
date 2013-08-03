//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewAttribute.h"
#import "MASConstraint.h"
#import "MASLayoutConstraint.h"

@interface MASViewConstraint : NSObject <MASConstraint, NSCopying>

/**
 *	Usually MASConstraintMaker but could be a parent MASConstraint
 */
@property (nonatomic, weak) id<MASConstraintDelegate> delegate;

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) MASViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) MASViewAttribute *secondViewAttribute;

/**
 *	The generate MASLayoutConstraint could be nil if -commit has not been called
 */
@property (nonatomic, strong, readonly) MASLayoutConstraint *layoutConstraint;

/**
 *	initialises the MASViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.mas_left, view.mas_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(MASViewAttribute *)firstViewAttribute;

@end