//
//  MASCompositeConstraintSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASCompositeConstraint.h"

SpecBegin(MASCompositeConstraint)

__block MASCompositeConstraint *composite;
__block id<MASConstraintDelegate> delegate;

beforeEach(^{
    delegate = mockProtocol(@protocol(MASConstraintDelegate));
});

describe(@"commit", ^{

    
    
});

describe(@"centering", ^{
    
    beforeEach(^{
        composite = [[MASCompositeConstraint alloc] initWithView:mock(UIView.class) type:MASCompositeViewConstraintTypeCenter];
        composite.delegate = delegate;
    });
    
    xit(@"should forward to children", ^{});
    
});

describe(@"sizing", ^{
    
    beforeEach(^{
        composite = [[MASCompositeConstraint alloc] initWithView:mock(UIView.class) type:MASCompositeViewConstraintTypeCenter];
        composite.delegate = delegate;
    });
    
    xit(@"should forward to children", ^{});
    
});

describe(@"alignment", ^{
    
    beforeEach(^{
        composite = [[MASCompositeConstraint alloc] initWithView:mock(UIView.class) type:MASCompositeViewConstraintTypeCenter];
        composite.delegate = delegate;
    });
    
    xit(@"should forward to children", ^{});
    
});

SpecEnd