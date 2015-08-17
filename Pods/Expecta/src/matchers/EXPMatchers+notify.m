#import "EXPMatchers+notify.h"

EXPMatcherImplementationBegin(notify, (id expected)){
  BOOL actualIsNil = (actual == nil);
  BOOL expectedIsNil = (expected == nil);
  BOOL isNotification = [expected isKindOfClass:[NSNotification class]];
  BOOL isName = [expected isKindOfClass:[NSString class]];
  
  __block NSString *expectedName;
  __block BOOL expectedNotificationOccurred = NO;
  __block id observer;
  
  prerequisite(^BOOL{
    expectedNotificationOccurred = NO;
    if (actualIsNil || expectedIsNil) return NO;
    if (isNotification) {
      expectedName = [expected name];
    }else if(isName) {
      expectedName = expected;
    }else{
      return NO;
    }
    
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:expectedName object:nil queue:nil usingBlock:^(NSNotification *note){
      if (isNotification) {
        expectedNotificationOccurred |= [expected isEqual:note];
      }else{
        expectedNotificationOccurred = YES;
      }
    }];
    ((EXPBasicBlock)actual)();
    return YES;
  });
  
  match(^BOOL{
    if(expectedNotificationOccurred) {
      [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    return expectedNotificationOccurred;
  });
  
  failureMessageForTo(^NSString *{
    if (observer) {
      [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    if(!(isNotification || isName)) return @"the actual value is not a notification or string";
    return [NSString stringWithFormat:@"expected: %@, got: none",expectedName];
  });
  
  failureMessageForNotTo(^NSString *{
    if (observer) {
      [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    if(!(isNotification || isName)) return @"the actual value is not a notification or string";
    return [NSString stringWithFormat:@"expected: none, got: %@", expectedName];
  });
}

EXPMatcherImplementationEnd
