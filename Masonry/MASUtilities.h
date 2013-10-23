//
//  MASUtilities.h
//  Masonry
//
//  Created by Jonas Budelmann on 19/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#if TARGET_OS_IPHONE

    #import <UIKit/UIKit.h>
    #define MAS_VIEW UIView
    #define MASEdgeInsets UIEdgeInsets

    enum {
        MASLayoutPriorityRequired = UILayoutPriorityRequired,
        MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh,
        MASLayoutPriorityDefaultMedium = 500,
        MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow,
        MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel,
    };
    typedef float MASLayoutPriority;

#elif TARGET_OS_MAC

    #import <AppKit/AppKit.h>
    #define MAS_VIEW NSView
    #define MASEdgeInsets NSEdgeInsets

    enum {
        MASLayoutPriorityRequired = NSLayoutPriorityRequired,
        MASLayoutPriorityDefaultHigh = NSLayoutPriorityDefaultHigh,
        MASLayoutPriorityDragThatCanResizeWindow = NSLayoutPriorityDragThatCanResizeWindow,
        MASLayoutPriorityDefaultMedium = 501,
        MASLayoutPriorityWindowSizeStayPut = NSLayoutPriorityWindowSizeStayPut,
        MASLayoutPriorityDragThatCannotResizeWindow = NSLayoutPriorityDragThatCannotResizeWindow,
        MASLayoutPriorityDefaultLow = NSLayoutPriorityDefaultLow,
        MASLayoutPriorityFittingSizeCompression = NSLayoutPriorityFittingSizeCompression,
    };
    typedef float MASLayoutPriority;

#endif

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

/**
 *  Used to create object hashes
 *  Based on http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
 */
#define MAS_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define MAS_NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (MAS_NSUINT_BIT - howmuch)))
