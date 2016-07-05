//
//  MASConstraintMaker+Forbearance.h
//  Star
//
//  Created by 星星 on 16/7/5.
//  Copyright © 2016年 Star.China All rights reserved.
//

#import "MASConstraintMaker.h"
#import "MASForbearance.h"

@interface MASConstraintMaker (Forbearance) <MASForbearanceDelegate>

@property (nonatomic, strong, readonly) MASForbearance *hugging;
@property (nonatomic, strong, readonly) MASForbearance *compression;
@property (nonatomic, strong, readonly) MASForbearance *compressionResistance;

@property (nonatomic, strong, readonly) MASForbearance *horizontal;
@property (nonatomic, strong, readonly) MASForbearance *vertical;

@end
