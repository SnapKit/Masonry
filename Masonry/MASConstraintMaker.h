//
//  MASConstraintBuilder.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASConstraint.h"
#import "MASUtilities.h"

@interface MASConstraintMaker : NSObject

/**
 *	The following properties return a new MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MASViewAttribute
 */
@property (nonatomic, strong, readonly) id<MASConstraint> left;
@property (nonatomic, strong, readonly) id<MASConstraint> top;
@property (nonatomic, strong, readonly) id<MASConstraint> right;
@property (nonatomic, strong, readonly) id<MASConstraint> bottom;
@property (nonatomic, strong, readonly) id<MASConstraint> leading;
@property (nonatomic, strong, readonly) id<MASConstraint> trailing;
@property (nonatomic, strong, readonly) id<MASConstraint> width;
@property (nonatomic, strong, readonly) id<MASConstraint> height;
@property (nonatomic, strong, readonly) id<MASConstraint> centerX;
@property (nonatomic, strong, readonly) id<MASConstraint> centerY;
@property (nonatomic, strong, readonly) id<MASConstraint> baseline;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) id<MASConstraint> edges;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) id<MASConstraint> size;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) id<MASConstraint> center;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any MASConstrait are created with this view as the first item
 *
 *	@return	a new MASConstraintMaker
 */
- (id)initWithView:(MAS_VIEW *)view;

/**
 *	Calls commit method on any MASConstraints which requested to be added view MASConstraintDelegate
 */
- (void)commit;

@end
