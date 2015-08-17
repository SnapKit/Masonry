#import "EXPExpect.h"

@interface EXPExpect (BackwardCompatiblity)

@property(nonatomic, readonly) EXPExpect *Not;
@property(nonatomic, readonly) EXPExpect *isGoing;
@property(nonatomic, readonly) EXPExpect *isNotGoing;

@end

#define toBeFalsy                     beFalsy
#define toBeGreaterThan               beGreaterThan
#define toBeGreaterThanOrEqualTo      beGreaterThanOrEqualTo
#define toBeIdenticalTo               beIdenticalTo
#define toBeInTheRangeOf              beInTheRangeOf
#define toBeInstanceOf                beInstanceOf
#define toBeAnInstanceOf              beInstanceOf
#define toBeMemberOf                  beInstanceOf
#define toBeAMemberOf                 beInstanceOf
#define toBeKindOf                    beKindOf
#define toBeAKindOf                   beKindOf
#define toBeLessThan                  beLessThan
#define toBeLessThanOrEqualTo         beLessThanOrEqualTo
#define toBeNil                       beNil
#define toBeNull                      beNil
#define toBeSubclassOf                beSubclassOf
#define toBeASubclassOf               beSubclassOf
#define toBeTruthy                    beTruthy
#define toBeFalsy                     beFalsy
#define toContain                     contain
#define toEqual                       equal
#define toBeCloseTo                   beCloseTo
#define toBeCloseToWithin             beCloseToWithin
#define toHaveCount                   haveCountOf
#define toHaveCountOf                 haveCountOf
#define toHaveACountOf                haveCountOf
#define toHaveLength                  haveCountOf
#define toHaveLengthOf                haveCountOf
#define toHaveALengthOf               haveCountOf
#define toBeEmpty                     beEmpty
#define toRaise                       raise
#define toRaiseAny                    raiseAny
