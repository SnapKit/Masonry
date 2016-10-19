#import "EXPUnsupportedObject.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
@implementation EXPUnsupportedObject
#pragma clang diagnostic pop

@synthesize type=_type;

- (instancetype)initWithType:(NSString *)type {
  self = [super init];
  if(self) {
    self.type = type;
  }
  return self;
}

- (void)dealloc {
  self.type = nil;
  [super dealloc];
}

@end
