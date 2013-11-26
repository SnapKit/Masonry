//
//  CASAppDelegate.m
//  MasonryTestsLoader
//
//  Created by Jonas Budelmann on 26/11/13.
//
//

#import "CASAppDelegate.h"

@implementation CASAppDelegate

+ (void)initialize {
    [[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GcovTestObserver"
                                             forKey:@"XCTestObserverClass"];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    extern void __gcov_flush(void);
    __gcov_flush();
}

@end
