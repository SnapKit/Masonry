#import <Foundation/Foundation.h>
#import "EXPMatcher.h"
#import "EXPDefines.h"

@interface EXPExpect : NSObject {
  EXPIdBlock _actualBlock;
  id _testCase;
  int _lineNumber;
  char *_fileName;
  BOOL _negative;
  BOOL _asynchronous;
}

@property(nonatomic, copy) EXPIdBlock actualBlock;
@property(nonatomic, readonly) id actual;
@property(nonatomic, assign) id testCase;
@property(nonatomic) int lineNumber;
@property(nonatomic) const char *fileName;
@property(nonatomic) BOOL negative;
@property(nonatomic) BOOL asynchronous;

@property(nonatomic, readonly) EXPExpect *to;
@property(nonatomic, readonly) EXPExpect *toNot;
@property(nonatomic, readonly) EXPExpect *notTo;
@property(nonatomic, readonly) EXPExpect *will;
@property(nonatomic, readonly) EXPExpect *willNot;

- (id)initWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(const char *)fileName;
+ (EXPExpect *)expectWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(const char *)fileName;

- (void)applyMatcher:(id<EXPMatcher>)matcher;
- (void)applyMatcher:(id<EXPMatcher>)matcher to:(NSObject **)actual;

@end

@interface EXPDynamicPredicateMatcher : NSObject <EXPMatcher> {
  EXPExpect *_expectation;
  SEL _selector;
}
- (id)initWithExpectation:(EXPExpect *)expectation selector:(SEL)selector;
- (void (^)(void))dispatch;
@end
