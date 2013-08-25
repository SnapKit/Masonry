//
//  MASConstraintMakerSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 25/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASConstraintMaker.h"
#import "MASCompositeConstraint.h"
#import "MASViewConstraint.h"

@interface MASConstraintMaker () <MASConstraintDelegate>

@property (nonatomic, weak) MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@interface MASCompositeConstraint ()

@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

SpecBegin(MASConstraintMaker)

__block MASConstraintMaker *maker;
__block MAS_VIEW *superview;
__block MAS_VIEW *view;
__block MASCompositeConstraint *composite;

beforeEach(^{
    composite = nil;
    view = MAS_VIEW.new;
    superview = MAS_VIEW.new;
    [superview addSubview:view];

    maker = [[MASConstraintMaker alloc] initWithView:view];
});

it(@"should create centerY and centerX children", ^{
    composite = maker.center;

    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = [composite.childConstraints objectAtIndex:0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeCenterX);

    viewConstraint = [composite.childConstraints objectAtIndex:1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeCenterY);
});

it(@"should create top, left, bottom, right children", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    composite = maker.edges;
    composite.equalTo(newView);

    expect(composite.childConstraints).to.haveCountOf(4);

    //top
    MASViewConstraint *viewConstraint = [composite.childConstraints objectAtIndex:0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeTop);

    //left
    viewConstraint = [composite.childConstraints objectAtIndex:1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeLeft);

    //bottom
    viewConstraint = [composite.childConstraints objectAtIndex:2];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeBottom);

    //right
    viewConstraint = [composite.childConstraints objectAtIndex:3];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeRight);
});

it(@"should create width and height children", ^{
    composite = maker.size;
    expect(composite.childConstraints).to.haveCountOf(2);

    MASViewConstraint *viewConstraint = [composite.childConstraints objectAtIndex:0];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);

    viewConstraint = [composite.childConstraints objectAtIndex:1];
    expect(viewConstraint.firstViewAttribute.view).to.beIdenticalTo(maker.view);
    expect(viewConstraint.firstViewAttribute.layoutAttribute).to.equal(NSLayoutAttributeHeight);
});

SpecEnd