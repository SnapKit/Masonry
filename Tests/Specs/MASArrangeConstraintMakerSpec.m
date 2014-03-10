//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//




#import "MASConstraintMaker.h"
#import "MASArrangeConstraintMaker.h"
#import "MASArrangeConstraint.h"


SpecBegin(MASArrangeConstraintMaker) {
    __strong MASArrangeConstraintMaker *maker;
    __strong MAS_VIEW *superview;
    __strong MAS_VIEW *view;
    __strong MAS_VIEW *view2;

}

- (void)setUp {
    view = MAS_VIEW.new;
    view2 = MAS_VIEW.new;
    superview = MAS_VIEW.new;
    [superview addSubview:view];
    [superview addSubview:view2];

    maker = [[MASArrangeConstraintMaker alloc] initWithViews:@[view, view2]];
}


- (void)testInstallRelativeToSuperview {
    MASArrangeConstraint *constraint = (MASArrangeConstraint *) maker.arrange.vertically.equalTo(@10);
    [constraint install];

    expect(maker.arrange).notTo.beNil;
    expect(constraint).notTo.beNil;

    expect(superview.constraints).to.haveCountOf(2);

    NSLayoutConstraint* c1 = superview.constraints.firstObject;
    expect(c1).to.notTo.beNil;
    expect(c1.constant).to.equal(10);
}


SpecEnd