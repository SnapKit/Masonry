//
//  MASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASConstraint.h"
#import "MASUtilities.h"

/**
 *	A group of MASConstraint objects
 */
@interface MASCompositeConstraint : MASConstraint

NS_ASSUME_NONNULL_BEGIN

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child MASConstraints
 *
 *	@return	a composite constraint
 */
- (instancetype)initWithChildren:(NSArray *)children;

NS_ASSUME_NONNULL_END

@end
