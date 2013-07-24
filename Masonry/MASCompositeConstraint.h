//
//  MASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraint.h"

typedef NS_ENUM(NSInteger, MASCompositeViewConstraintType) {
    MASCompositeViewConstraintTypeEdges, //top, left, bottom, right
    MASCompositeViewConstraintTypeSize, //width, height
    MASCompositeViewConstraintTypeCenter, //centerX, centerY
};

@interface MASCompositeConstraint : NSObject <MASConstraint>

@property (nonatomic, weak) id<MASConstraintDelegate> delegate;
@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, assign, readonly) MASCompositeViewConstraintType type;

- (id)initWithView:(UIView *)view type:(MASCompositeViewConstraintType)type;

@end
