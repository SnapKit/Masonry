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
	// https://github.com/fastlane/fastlane/issues/3886#issuecomment-224884332
	// XCode 7.3 introduced a bug where early registration of a test observer prevented
	// default XCTest test observer from being registered. That caused no logs being printed
	// onto console, which in result broke several tools that relied on this.
	// In order to go around the issue we're deferring registration to allow default
	// test observer to register first.
	dispatch_async(dispatch_get_main_queue(), ^{
		[[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GcovTestObserver"
												 forKey:@"XCTestObserverClass"];
	});
}

- (void)applicationWillTerminate:(UIApplication *)application {
    extern void __gcov_flush(void);
    __gcov_flush();
}

@end
