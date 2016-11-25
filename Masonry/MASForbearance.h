//
//  MASForbearance.h
//  Star
//
//  Created by 星星 on 16/7/5.
//  Copyright © 2016年 Star.China All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASUtilities.h"

typedef NS_OPTIONS(NSUInteger, MASForbearanceRule) {
    MASForbearanceRuleHorizontal     = 0x01 << 0,
    MASForbearanceRuleVertical       = 0x01 << 1,
    MASForbearanceRuleHugging        = 0x01 << 2,
    MASForbearanceRuleCompression    = 0x01 << 3
};


@class MASForbearance;

@protocol MASForbearanceDelegate <NSObject>

- (MASForbearance *)forbearance:(MASForbearance *)forbearance addForbearanceRule:(MASForbearanceRule)forbearanceRule;

- (MASForbearance *)forbearance:(MASForbearance *)forbearance priority:(MASLayoutPriority)priority;

@end

@interface MASForbearance : NSObject

@property (nonatomic, weak) id<MASForbearanceDelegate> delegate;

// Action
- (MASForbearance *)hugging;
- (MASForbearance *)compression;
- (MASForbearance *)compressionResistance;

// Axis
- (MASForbearance *)horizontal;
- (MASForbearance *)vertical;

// Priority
- (MASForbearance *(^)(MASLayoutPriority priority))priority;
- (MASForbearance *(^)())priorityRequired;
- (MASForbearance *(^)())priorityHigh;
- (MASForbearance *(^)())priorityMedium;
- (MASForbearance *(^)())priorityLow;
- (MASForbearance *(^)())priorityFittingSizeLevel;

@end
