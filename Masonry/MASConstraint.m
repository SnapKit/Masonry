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

- (MASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.valueOffset = MASBoxValue(offset);
        return self;
    };
}

- (MASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.valueOffset = MASBoxValue(offset);
        return self;
    };
}

- (MASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.valueOffset = MASBoxValue(offset);
        return self;
    };
}

- (MASConstraint * (^)(id))_valueOffset {
    return ^id(id offset) {
        self.valueOffset = offset;
        return self;
    };
}

- (MASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
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

- (void)setValueOffset:(id)offset { methodNotImplemented(); }

- (void)setInsets:(MASEdgeInsets)insets { methodNotImplemented(); }

#if TARGET_OS_MAC && !TARGET_OS_IPHONE

- (MASConstraint *)animator { methodNotImplemented(); }

#endif

- (void)install { methodNotImplemented(); }

- (void)uninstall { methodNotImplemented(); }

@end
