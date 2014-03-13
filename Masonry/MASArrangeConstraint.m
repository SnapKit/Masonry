//
//  Copyright (c) 2014 Alexey Afanasev. All rights reserved.
//



#import "MASViewConstraint.h"
#import "MASArrangeConstraint.h"
#import "MASArrangeConstraintMaker.h"


@interface MASArrangeConstraint ()
@property(nonatomic, strong) NSArray *views;
@property(nonatomic, retain) NSMutableArray *constraints;
@property(nonatomic, strong) NSNumber * constant;
@property(nonatomic, copy) NSString *asciiFormat;
@end

@implementation MASArrangeConstraint {
}


- (id)initWith:(NSArray *)array {
    self = [super init];

    self.views = array;
    self.constraints = [NSMutableArray array];

    return self;
}


- (void)install {
    if (self.asciiFormat == nil) {
        [self regularArrangement];
    } else {
        [self asciiArrangement];
    }

}

- (void)asciiArrangement {
    int number = 0;
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    for (MAS_VIEW *view in self.views) {
        number++;
        [mapping setObject:view forKey:[NSString stringWithFormat:@"v%d", number]];
    }

    if (self.isVertical){
        self.asciiFormat = [@"V:" stringByAppendingString:self.asciiFormat];
    }

    NSLayoutFormatOptions opts = self.isVertical ? NSLayoutFormatAlignAllLeft : NSLayoutFormatAlignAllCenterY;
    NSArray *layoutConstraint = [MASLayoutConstraint constraintsWithVisualFormat:self.asciiFormat options:opts metrics:nil views:mapping];

    // todo check if all view are subviews of the same superview
    MAS_VIEW*firstSuperview = ((MAS_VIEW *) self.views.firstObject).superview;
    [firstSuperview addConstraints:layoutConstraint];
}

- (void)regularArrangement {
    NSLayoutAttribute attribute = self.isVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeft;
    NSLayoutAttribute compoundAttribute = self.isVertical ? NSLayoutAttributeBottom : NSLayoutAttributeRight;

    MAS_VIEW* superview = ((MAS_VIEW *) self.views.firstObject).superview;
    MASViewAttribute *secondViewAttribute = [[MASViewAttribute alloc] initWithView:superview layoutAttribute:attribute];


    for (MAS_VIEW *uiView in self.views) {
        uiView.translatesAutoresizingMaskIntoConstraints = NO;
        MASViewAttribute *firstViewAttribute = [[MASViewAttribute alloc] initWithView:uiView layoutAttribute:attribute];
        MASViewConstraint *constraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:firstViewAttribute andSecond:secondViewAttribute];
        constraint.offset(self.constant.floatValue);
        [self.constraints addObject:constraint];

        // assign next one
        secondViewAttribute = [[MASViewAttribute alloc] initWithView:uiView layoutAttribute:compoundAttribute];
    }

    for (MASViewConstraint *viewConstraint in self.constraints) {
        [viewConstraint install];
    }
}


- (MASArrangeConstraint * (^)(id))withOffset {
    return ^id(id attribute) {
        NSAssert([attribute isKindOfClass:[NSNumber class]], @"Only NSNumber is accepted here");
        self.constant = attribute;
        return self;
    };
}

- (MASArrangeConstraint * (^)(id))ascii {
    return ^id(NSString * attribute) {
        self.asciiFormat = attribute;
        return self;
    };
}

@end