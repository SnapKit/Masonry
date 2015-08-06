//
//  MASExampleListViewController.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleListViewController.h"
#import "MASExampleViewController.h"
#import "MASExampleBasicView.h"
#import "MASExampleConstantsView.h"
#import "MASExampleSidesView.h"
#import "MASExampleAnimatedView.h"
#import "MASExampleDebuggingView.h"
#import "MASExampleLabelView.h"
#import "MASExampleUpdateView.h"
#import "MASExampleRemakeView.h"
#import "MASExampleScrollView.h"
#import "MASExampleLayoutGuideViewController.h"
#import "MASExampleArrayView.h"
#import "MASExampleAttributeChainingView.h"
#import "MASExampleAspectFitView.h"
#import "MASExampleMarginView.h"
#import "MASExampleDistributeView.h"

static NSString * const kMASCellReuseIdentifier = @"kMASCellReuseIdentifier";

@interface MASExampleListViewController ()

@property (nonatomic, strong) NSArray *exampleControllers;

@end

@implementation MASExampleListViewController

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.title = @"Examples";
    
    self.exampleControllers = @[
        [[MASExampleViewController alloc] initWithTitle:@"Basic"
                                              viewClass:MASExampleBasicView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Update Constraints"
                                              viewClass:MASExampleUpdateView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Remake Constraints"
                                              viewClass:MASExampleRemakeView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Using Constants"
                                              viewClass:MASExampleConstantsView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Composite Edges"
                                              viewClass:MASExampleSidesView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Aspect Fit"
                                              viewClass:MASExampleAspectFitView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Basic Animated"
                                              viewClass:MASExampleAnimatedView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Debugging Helpers"
                                              viewClass:MASExampleDebuggingView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Bacony Labels"
                                              viewClass:MASExampleLabelView.class],
        [[MASExampleViewController alloc] initWithTitle:@"UIScrollView"
                                              viewClass:MASExampleScrollView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Array"
                                              viewClass:MASExampleArrayView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Attribute Chaining"
                                              viewClass:MASExampleAttributeChainingView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Margins"
                                              viewClass:MASExampleMarginView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Views Distribute"
                                              viewClass:MASExampleDistributeView.class],

    ];
    
    if ([UIViewController instancesRespondToSelector:@selector(topLayoutGuide)])
    {
        self.exampleControllers = [self.exampleControllers arrayByAddingObject:[[MASExampleLayoutGuideViewController alloc] init]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kMASCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMASCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = viewController.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleControllers.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
