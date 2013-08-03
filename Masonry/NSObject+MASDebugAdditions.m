//
//  NSObject+MASDebugAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 3/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSObject+MASDebugAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (MASDebugAdditions)

- (NSString *)mas_debugName {
    return objc_getAssociatedObject(self, @selector(mas_debugName));
}

- (void)setMas_debugName:(NSString *)debugName {
    objc_setAssociatedObject(self, @selector(mas_debugName), debugName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
