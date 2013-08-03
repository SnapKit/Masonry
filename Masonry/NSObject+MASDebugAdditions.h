//
//  NSObject+MASDebugAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 3/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MASDebugAdditions)

@property (nonatomic, strong) NSString *mas_debugName;

@end

#define MASAttachDebugNames(...)                                              \
    NSDictionary *debugPairs = NSDictionaryOfVariableBindings(__VA_ARGS__);   \
    for (id key in debugPairs.allKeys) {                                      \
        [debugPairs[key] setMas_debugName:key];                               \
    }
    