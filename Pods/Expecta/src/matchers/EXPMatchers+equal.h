#import "Expecta.h"

EXPMatcherInterface(_equal, (id expected));
EXPMatcherInterface(equal, (id expected)); // to aid code completion
#define equal(expected) _equal(EXPObjectify((expected)))
