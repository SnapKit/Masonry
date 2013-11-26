//
//  GcovTestObserver.m
//  ClassyTests
//
//  Created by Jonas Budelmann on 19/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <XCTest/XCTestObserver.h>

@interface GcovTestObserver : XCTestObserver
@end

@implementation GcovTestObserver

- (void)stopObserving {
    [super stopObserving];
    UIApplication* application = [UIApplication sharedApplication];
    [application.delegate applicationWillTerminate:application];
}

@end