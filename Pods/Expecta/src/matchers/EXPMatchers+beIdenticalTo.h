#import "Expecta.h"

EXPMatcherInterface(_beIdenticalTo, (void *expected));

#if __has_feature(objc_arc)
#define beIdenticalTo(expected) _beIdenticalTo((__bridge void*)expected)
#else
#define beIdenticalTo _beIdenticalTo
#endif
