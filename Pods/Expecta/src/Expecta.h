#import <Foundation/Foundation.h>
#import "ExpectaSupport.h"

#define EXPObjectify(value) _EXPObjectify(@encode(__typeof__((value))), (value))

#define EXP_expect(actual) _EXP_expect(self, __LINE__, __FILE__, ^id{ return EXPObjectify((actual)); })

#define EXPMatcherInterface(matcherName, matcherArguments) _EXPMatcherInterface(matcherName, matcherArguments)
#define EXPMatcherImplementationBegin(matcherName, matcherArguments) _EXPMatcherImplementationBegin(matcherName, matcherArguments)
#define EXPMatcherImplementationEnd _EXPMatcherImplementationEnd

#import "EXPMatchers.h"

#ifdef EXP_SHORTHAND
#  define expect(actual) EXP_expect((actual))
#endif

#ifdef EXP_OLD_SYNTAX
#  import "EXPBackwardCompatibility.h"
#endif

@interface Expecta : NSObject

+ (NSTimeInterval)asynchronousTestTimeout;
+ (void)setAsynchronousTestTimeout:(NSTimeInterval)timeout;

@end
