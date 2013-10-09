//
//  MASViewAttributeSpec.m
//  Masonry
//
//  Created by Craig Siemens on 2013-10-09.
//  Copyright 2013 Jonas Budelmann. All rights reserved.
//

#import "MASViewAttribute.h"

SpecBegin(MASViewAttributeSpec)

__block UIView *view;
__block MASViewAttribute *viewAttribute;

beforeEach(^{
    view = [UIView new];
    viewAttribute = [[MASViewAttribute alloc] initWithView:view layoutAttribute:NSLayoutAttributeLeft];
});

context(@"isEqual", ^{
    
    it(@"should return YES whe the view and layoutAttribute are the same", ^{
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:viewAttribute.view
                                                                      layoutAttribute:viewAttribute.layoutAttribute];
        expect([viewAttribute isEqual:otherViewAttribute]).to.equal(YES);
    });
    
    it(@"should return NO when the view is different but the layoutAttribute is the same", ^{
        UIView *otherView = [UIView new];
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:otherView
                                                                      layoutAttribute:viewAttribute.layoutAttribute];
        expect([viewAttribute isEqual:otherViewAttribute]).to.equal(NO);
    });
    
    it(@"should return NO when the view is the same but the layoutAttribute is different", ^{
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:viewAttribute.view
                                                                      layoutAttribute:NSLayoutAttributeRight];
        expect([viewAttribute isEqual:otherViewAttribute]).to.equal(NO);
    });

    it(@"should return NO when the view is different and the layoutAttribute is different", ^{
        UIView *otherView = [UIView new];
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:otherView
                                                                      layoutAttribute:NSLayoutAttributeRight];
        expect([viewAttribute isEqual:otherViewAttribute]).to.equal(NO);
    });
});

context(@"hash", ^{
    
    it(@"should return the same hash when the view and layoutAttribute are the same", ^{
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:viewAttribute.view
                                                                      layoutAttribute:viewAttribute.layoutAttribute];
        expect([viewAttribute hash]).to.equal([otherViewAttribute hash]);
    });
    
    it(@"should return a different hash when the view is different but the layoutAttribute is the same", ^{
        UIView *otherView = [UIView new];
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:otherView
                                                                      layoutAttribute:viewAttribute.layoutAttribute];
        expect([viewAttribute hash]).toNot.equal([otherViewAttribute hash]);
    });
    
    it(@"should return a different hash when the view is the same but the layoutAttribute is different", ^{
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:viewAttribute.view
                                                                      layoutAttribute:NSLayoutAttributeRight];
        expect([viewAttribute hash]).toNot.equal([otherViewAttribute hash]);
    });
    
    it(@"should return a different hash when the view is different and the layoutAttribute is different", ^{
        UIView *otherView = [UIView new];
        MASViewAttribute *otherViewAttribute = [[MASViewAttribute alloc] initWithView:otherView
                                                                      layoutAttribute:NSLayoutAttributeRight];
        expect([viewAttribute hash]).toNot.equal([otherViewAttribute hash]);
    });
});

SpecEnd
