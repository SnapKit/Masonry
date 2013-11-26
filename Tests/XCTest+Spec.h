//
//  Spec.h
//  ClassyTests
//
//  Created by Jonas Budelmann on 18/10/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

// declare XCTestCase subclass interface and implementation
#define SpecBegin(name)                 \
@interface name##Spec : XCTestCase @end \
@implementation name##Spec

// close XCTestCase
#define SpecEnd \
@end