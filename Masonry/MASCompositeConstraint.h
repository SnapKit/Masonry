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
};

@interface MASCompositeConstraint : NSObject <MASConstraint>

@property (nonatomic, weak) id<MASConstraintDelegate> delegate;
@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, assign, readonly) MASCompositeConstraintType type;

- (id)initWithView:(UIView *)view type:(MASCompositeConstraintType)type;
- (id)initWithView:(UIView *)view children:(NSArray *)children;

@end
