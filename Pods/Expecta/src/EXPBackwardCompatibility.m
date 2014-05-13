#import "EXPBackwardCompatibility.h"

@implementation EXPExpect (BackwardCompatiblity)

- (EXPExpect *)Not {
  return self.toNot;
}

- (EXPExpect *)isGoing {
  return self.will;
}

- (EXPExpect *)isNotGoing {
  return self.willNot;
}

@end
