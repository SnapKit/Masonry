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

- (void)testDistributeViewsWithFixedSpacingShouldFailWhenArrayContainsLessTwoViews {
    MAS_VIEW *superView = MAS_VIEW.new;
    
    MAS_VIEW *subject1 = MAS_VIEW.new;
    [superView addSubview:subject1];
    
    MAS_VIEW *subject2 = MAS_VIEW.new;
    [superView addSubview:subject2];
    NSArray *views = @[ subject1];
    expect(^{
        [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10.0 leadSpacing:5.0 tailSpacing:5.0];
    }).to.raiseAny();
    
}

- (void)testDistributeViewsWithFixedItemLengthShouldFailWhenArrayContainsLessTwoViews {
    MAS_VIEW *superView = MAS_VIEW.new;
    
    MAS_VIEW *subject1 = MAS_VIEW.new;
    [superView addSubview:subject1];
    
    MAS_VIEW *subject2 = MAS_VIEW.new;
    [superView addSubview:subject2];
    NSArray *views = @[ subject1];
    expect(^{
        [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:10.0 leadSpacing:5.0 tailSpacing:5.0];
    }).to.raiseAny();
    
}

- (void)testDistributeViewsWithFixedSpacingShouldHaveCorrectNumberOfConstraints {
    MAS_VIEW *superView = MAS_VIEW.new;
    
    MAS_VIEW *subject1 = MAS_VIEW.new;
    [superView addSubview:subject1];
    
    MAS_VIEW *subject2 = MAS_VIEW.new;
    [superView addSubview:subject2];
    
    MAS_VIEW *subject3 = MAS_VIEW.new;
    [superView addSubview:subject3];
    
    NSArray *views = @[ subject1,subject2,subject3 ];

    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10.0 leadSpacing:5.0 tailSpacing:5.0];
    
    //left view
    NSArray *arr1 = [MASViewConstraint installedConstraintsForView:subject1];
    expect(arr1).to.haveCountOf(1);
   
    //middle view
    NSArray *arr2 = [MASViewConstraint installedConstraintsForView:subject2];
    expect(arr2).to.haveCountOf(2);
    
    //right view
    NSArray *arr3 = [MASViewConstraint installedConstraintsForView:subject3];
    expect(arr3).to.haveCountOf(3);
}

- (void)testDistributeViewsWithFixedItemLengthShouldHaveCorrectNumberOfConstraints {
    MAS_VIEW *superView = MAS_VIEW.new;
    
    MAS_VIEW *subject1 = MAS_VIEW.new;
    [superView addSubview:subject1];
    
    MAS_VIEW *subject2 = MAS_VIEW.new;
    [superView addSubview:subject2];
    
    MAS_VIEW *subject3 = MAS_VIEW.new;
    [superView addSubview:subject3];
    
    NSArray *views = @[ subject1,subject2,subject3 ];
   
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30.0 leadSpacing:5.0 tailSpacing:5.0];
    
    //left view
    NSArray *arr1 = [MASViewConstraint installedConstraintsForView:subject1];
    expect(arr1).to.haveCountOf(2);
    
    //middle view
    NSArray *arr2 = [MASViewConstraint installedConstraintsForView:subject2];
    expect(arr2).to.haveCountOf(2);
    
    //right view
    NSArray *arr3 = [MASViewConstraint installedConstraintsForView:subject3];
    expect(arr3).to.haveCountOf(2);
}


SpecEnd
