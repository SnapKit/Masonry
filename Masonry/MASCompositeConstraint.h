//
//  MASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraint.h"

typedef NS_ENUM(NSInteger, MASCompositeConstraintType) {
    MASCompositeConstraintTypeEdges, //top, left, bottom, right
    MASCompositeConstraintTypeSize, //width, height
    MASCompositeConstraintTypeCenter, //centerX, centerY
    MASCompositeConstraintTypeUnknown, //could be mixture of any attributes
};

/**
 *	A group of MASConstraint objects
 *  conforms to MASConstraint
 */
@interface MASCompositeConstraint : NSObject <MASConstraint>

/**
 *	Usually MASConstraintMaker but could be a parent MASConstraint
 */
@property (nonatomic, weak) id<MASConstraintDelegate> delegate;

/**
 *	default first item for any child MASConstraints
 */
@property (nonatomic, weak, readonly) UIView *view;

/**
 *	type of Composite, used internally to generate child MASViewConstraits
 */
@property (nonatomic, assign, readonly) MASCompositeConstraintType type;

/**
 *	Creates a composite and automatically generates child MASViewConstraints
 *  Appriopriate to the type
 *
 *	@param	view	first item view
 *	@param	type	determines what kind of child constraints to generate
 *
 *	@return	a composite constraint
 */
- (id)initWithView:(UIView *)view type:(MASCompositeConstraintType)type;

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	view	first item view
 *	@param	children	child MASConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithView:(UIView *)view children:(NSArray *)children;

@end
