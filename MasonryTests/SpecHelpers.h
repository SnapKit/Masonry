//
//  SpecHelpers.h
//  Masonry
//
//  Created by Jonas Budelmann on 23/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASCompositeConstraint.h"
#import "MASViewAttribute.h"
#import "MASViewConstraint.h"

static id (^createViewAttribute)(NSLayoutAttribute layoutAttribute) = ^id(NSLayoutAttribute layoutAttribute) {
    UIView *view = UIView.new;
    MASViewAttribute *viewAttribute = [[MASViewAttribute alloc] initWithView:view layoutAttribute:layoutAttribute];
    return viewAttribute;
};

static id (^createConstraintWithLayoutAttribute)(NSLayoutAttribute layoutAttribute) = ^id(NSLayoutAttribute layoutAttribute) {
    id delegate = mockProtocol(@protocol(MASConstraintDelegate));
    MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:createViewAttribute(layoutAttribute)];
    constraint.delegate = delegate;
    return constraint;
};

static id(^createCompositeWithType)(MASCompositeViewConstraintType type) = ^id(MASCompositeViewConstraintType type){
    id delegate = mockProtocol(@protocol(MASConstraintDelegate));
    UIView *view = UIView.new;
    MASCompositeConstraint *composite = [[MASCompositeConstraint alloc] initWithView:view type:type];
    composite.delegate = delegate;
    return composite;
};