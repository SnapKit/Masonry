//
//  NSArray+MASAdditionsSpec.m
//  Masonry
//
//  Created by Daniel Hammond on 11/26/13.
//

#import "NSArray+MASAdditions.h"
#import "MASViewConstraint.h"

SpecBegin(NSArray_MASAdditions)

- (void)testShouldFailWhenArrayContainsNonViews {
    NSArray *array = @[ MAS_VIEW.new, [NSObject new] ];
    expect(^{
        [array mas_makeConstraints:^(MASConstraintMaker *make) {}];
    }).to.raise(@"NSInternalInconsistencyException");
}

- (void)testShouldCreateConstraintsForEachView {
    MAS_VIEW *superView = MAS_VIEW.new;
    
    MAS_VIEW *subject1 = MAS_VIEW.new;
    [superView addSubview:subject1];
    
    MAS_VIEW *subject2 = MAS_VIEW.new;
    [superView addSubview:subject2];
    
    NSArray *views = @[ subject1, subject2 ];
    
    NSArray *constraints = [views mas_makeConstraints:^(MASConstraintMaker *make) {
        expect(make.updateExisting).to.beFalsy();
        make.width.equalTo(superView);
    }];
    
    expect(constraints).to.haveCountOf(views.count);
    
    for (MASViewConstraint *constraint in constraints) {
        MASViewAttribute *firstAttribute = [constraint firstViewAttribute];
        expect([views indexOfObject:firstAttribute.view]).toNot.equal(NSNotFound);
        expect(firstAttribute.layoutAttribute).to.equal(NSLayoutAttributeWidth);
        MASViewAttribute *second = [constraint secondViewAttribute];
        expect(second.view).to.equal(superView);
        expect(second.layoutAttribute).to.equal(NSLayoutAttributeWidth);
    }
}

- (void)testShouldSetUpdateExistingForArray {
    NSArray *views = @[ MAS_VIEW.new ];
    [views mas_updateConstraints:^(MASConstraintMaker *make) {
        expect(make.updateExisting).to.beTruthy();
    }];
}

- (void)testShouldSetRemoveExistingForArray {
    NSArray *views = @[ MAS_VIEW.new ];
    [views mas_remakeConstraints:^(MASConstraintMaker *make) {
        expect(make.removeExisting).to.beTruthy();
    }];
}

SpecEnd
