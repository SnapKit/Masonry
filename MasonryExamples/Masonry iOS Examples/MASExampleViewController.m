//
//  MASExampleOneViewController.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleViewController.h"
#import "MASExampleBasicView.h"

@interface MASExampleViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation MASExampleViewController

- (id)initWithTitle:(NSString *)title viewClass:(Class)viewClass {
    self = [super init];
    if (!self) return nil;
    
    self.title = title;
    self.viewClass = viewClass;
    
    return self;
}

- (void)loadView {
    self.view = self.viewClass.new;
}

@end
