//
//  NSLayoutConstraint+MASDebugAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 3/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	makes debug and log output of NSLayoutConstraints more readable
 */
@interface NSLayoutConstraint (MASDebugAdditions)

@end

/**
 *	Allows you to attach keys to objects matching the variable names passed.
 *
 *  view1.mas_key = @"view1", view2.mas_key = @"view2";
 *
 *  is equivalent to:
 *
 *  MASAttachKeys(view1, view2);
 */
#define MASAttachKeys(...)                                                    \
    NSDictionary *keyPairs = NSDictionaryOfVariableBindings(__VA_ARGS__);     \
    for (id key in keyPairs.allKeys) {                                        \
        id obj = keyPairs[key];                                               \
        NSAssert([obj respondsToSelector:@selector(setMas_key:)],             \
                 @"Cannot attach mas_key to %@", obj);                        \
        [obj setMas_key:key];                                                 \
    }