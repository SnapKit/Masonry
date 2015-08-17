#import "Expecta.h"

EXPMatcherInterface(beInstanceOf, (Class expected));

#define beAnInstanceOf beInstanceOf
#define beMemberOf beInstanceOf
#define beAMemberOf beInstanceOf
