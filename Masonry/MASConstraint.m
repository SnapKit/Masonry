//
//  MASConstraint.m
//  Masonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "MASConstraint.h"
#import "MASConstraint+Private.h"

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

#pragma mark - NSLayoutRelation proxies

- (MASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self._equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (MASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self._equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (MASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self._equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - MASLayoutPriority proxies

- (MASConstraint * (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (MASConstraint * (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (MASConstraint * (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (MASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (MASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (MASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (MASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (MASConstraint * (^)(id))_valueOffset {
    return ^id(id offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (MASConstraint *)with {
    return self;
}

#pragma mark - Autocompletion dummies

- (MASConstraint * (^)(id attr))mas_equalTo { return nil; }

- (MASConstraint * (^)(id attr))mas_greaterThanOrEqualTo { return nil; }

- (MASConstraint * (^)(id attr))mas_lessThanOrEqualTo { return nil; }

- (MASConstraint * (^)(id offset))mas_offset { return nil; }

#pragma mark - Abstract

- (MASConstraint * (^)(CGFloat multiplier))multipliedBy { methodNotImplemented(); }

- (MASConstraint * (^)(CGFloat divider))dividedBy { methodNotImplemented(); }

- (MASConstraint * (^)(MASLayoutPriority priority))priority { methodNotImplemented(); }

- (MASConstraint * (^)(id, NSLayoutRelation))_equalToWithRelation { methodNotImplemented(); }

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
