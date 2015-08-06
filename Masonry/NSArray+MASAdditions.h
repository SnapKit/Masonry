//
//  NSArray+MASAdditions.h
//
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "MASUtilities.h"
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

typedef NS_ENUM(NSUInteger, MASAxisType) {
    MASAxisTypeHorizon,
    MASAxisTypeVertical
};

@interface NSArray (MASAdditions)

/**
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing on each view
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void (^)(MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void (^)(MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  All constraints previously installed for the views will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void (^)(MASConstraintMaker *make))block;

/**
 *  distribute with fixed spaceing
 *
 *  @param axisType     horizon/vertical
 *  @param paddingSpace space
 *  @param leadSpacing  head
 *  @param tailSpacing  tail
 */
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)paddingSpace leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

/**
 *  distribute with fixed item size
 *
 *  @param axisType    horizon/vertical
 *  @param itemLength  item size
 *  @param leadSpacing head
 *  @param tailSpacing  tail
 */
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)itemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end
