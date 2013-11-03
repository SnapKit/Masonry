//
//  View+MASAdditionsSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 8/09/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASAdditions.h"

SpecBegin(View_MASAdditions)

it(@"should set translatesAutoresizingMaskIntoConstraints", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    [newView mas_makeConstraints:^(MASConstraintMaker *make) {
        expect(make.updateExisting).to.beFalsy();
    }];

    expect(newView.translatesAutoresizingMaskIntoConstraints).to.beFalsy();
});

it(@"should set updateExisting", ^{
    MAS_VIEW *newView = MAS_VIEW.new;
    [newView mas_updateConstraints:^(MASConstraintMaker *make) {
        expect(make.updateExisting).to.beTruthy();
    }];

    expect(newView.translatesAutoresizingMaskIntoConstraints).to.beFalsy();
});

SpecEnd