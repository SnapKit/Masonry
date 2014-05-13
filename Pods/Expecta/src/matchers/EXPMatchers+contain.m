#import "EXPMatchers+contain.h"

EXPMatcherImplementationBegin(_contain, (id expected)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSString class]] || [actual conformsToProtocol:@protocol(NSFastEnumeration)];
  BOOL expectedIsNil = (expected == nil);
  BOOL actualIsDictionary = [actual isKindOfClass:[NSDictionary class]];
  BOOL expectedIsDictionary = [expected isKindOfClass:[NSDictionary class]];
  BOOL bothOrNeitherDictionaries = (actualIsDictionary && expectedIsDictionary) || (!actualIsDictionary && !expectedIsDictionary);

  prerequisite(^BOOL{
    return actualIsCompatible && !expectedIsNil && bothOrNeitherDictionaries;
  });

  match(^BOOL{
    if(actualIsCompatible) {
      if([actual isKindOfClass:[NSString class]]) {
        return [(NSString *)actual rangeOfString:[expected description]].location != NSNotFound;
      } else if ([actual isKindOfClass:[NSDictionary class]]) {
        NSArray *expectedKeys = [expected allKeys];
        id notFoundMarker = [NSObject new];
        NSArray *expectedValues = [expected objectsForKeys:expectedKeys notFoundMarker:notFoundMarker];
        NSArray *actualValues = [actual objectsForKeys:expectedKeys notFoundMarker:notFoundMarker];
        [notFoundMarker release];
        return [actualValues isEqual:expectedValues];
      } else {
        for (id object in actual) {
          if ([object isEqual:expected]) {
            return YES;
          }
        }
      }
    }
    return NO;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString or NSFastEnumeration", EXPDescribeObject(actual)];
    if(expectedIsNil) return @"the expected value is nil/null";
    if(!bothOrNeitherDictionaries) {
      if (actualIsDictionary) {
        return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary", EXPDescribeObject(expected)];
      } else {
        return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary", EXPDescribeObject(actual)];
      }
    }
    return [NSString stringWithFormat:@"expected %@ to contain %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString or NSFastEnumeration", EXPDescribeObject(actual)];
    if(expectedIsNil) return @"the expected value is nil/null";
    if(!bothOrNeitherDictionaries) {
      if (actualIsDictionary) {
        return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary", EXPDescribeObject(expected)];
      } else {
        return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary", EXPDescribeObject(actual)];
      }
    }
    return [NSString stringWithFormat:@"expected %@ not to contain %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
}
EXPMatcherImplementationEnd
