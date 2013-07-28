//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASViewAttribute.h"
#import "MASConstraint.h"

@interface MASViewConstraint : NSObject <MASConstraint, NSCopying>

@property (nonatomic, weak) id<MASConstraintDelegate> delegate;
@property (nonatomic, strong, readonly) MASViewAttribute *firstViewAttribute;
@property (nonatomic, strong, readonly) MASViewAttribute *secondViewAttribute;

- (id)initWithFirstViewAttribute:(MASViewAttribute *)firstViewAttribute;

@end