//
//  MASConstraint.m
//  Masonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "MASConstraint.h"

#define methodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation MASConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[MASConstraint class]], @"MASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - Abstract

- (MASConstraint * (^)(MASEdgeInsets insets))insets { methodNotImplemented(); }

- (MASConstraint * (^)(CGSize offset))sizeOffset { methodNotImplemented(); }

- (MASConstraint * (^)(CGPoint offset))centerOffset { methodNotImplemented(); }

- (MASConstraint * (^)(CGFloat offset))offset { methodNotImplemented(); }

- (MASConstraint * (^)(CGFloat multiplier))multipliedBy { methodNotImplemented(); }

- (MASConstraint * (^)(CGFloat divider))dividedBy { methodNotImplemented(); }

- (MASConstraint * (^)(MASLayoutPriority priority))priority { methodNotImplemented(); }

- (MASConstraint * (^)())priorityLow { methodNotImplemented(); }

- (MASConstraint * (^)())priorityMedium { methodNotImplemented(); }

- (MASConstraint * (^)())priorityHigh { methodNotImplemented(); }

- (MASConstraint * (^)(id attr))equalTo { methodNotImplemented(); }

- (MASConstraint * (^)(id attr))greaterThanOrEqualTo { methodNotImplemented(); }

- (MASConstraint * (^)(id attr))lessThanOrEqualTo { methodNotImplemented(); }

- (MASConstraint *)with { methodNotImplemented(); }

- (MASConstraint * (^)(id key))key { methodNotImplemented(); }

- (void)setInsets:(MASEdgeInsets)insets { methodNotImplemented(); }

- (void)setSizeOffset:(CGSize)sizeOffset { methodNotImplemented(); }

- (void)setCenterOffset:(CGPoint)centerOffset { methodNotImplemented(); }

- (void)setOffset:(CGFloat)offset { methodNotImplemented(); }

#if TARGET_OS_MAC && !TARGET_OS_IPHONE

- (MASConstraint *)animator { methodNotImplemented(); }

#endif

- (void)install { methodNotImplemented(); }

- (void)uninstall { methodNotImplemented(); }

@end
