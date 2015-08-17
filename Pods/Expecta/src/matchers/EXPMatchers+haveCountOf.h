#import "Expecta.h"

EXPMatcherInterface(haveCountOf, (NSUInteger expected));

#define haveCount     haveCountOf
#define haveACountOf  haveCountOf
#define haveLength    haveCountOf
#define haveLengthOf  haveCountOf
#define haveALengthOf haveCountOf
#define beEmpty()     haveCountOf(0)
