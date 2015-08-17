#import <Foundation/Foundation.h>

@interface EXPDoubleTuple : NSObject {
    double *_values;
    size_t _size;
}

@property (nonatomic, assign) double *values;
@property (nonatomic, assign) size_t size;

- (id)initWithDoubleValues:(double *)values size:(size_t)size;

@end
