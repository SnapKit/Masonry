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
        [[MASExampleViewController alloc] initWithTitle:@"Basic" viewClass:MASExampleBasicView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Using Constants" viewClass:MASExampleConstantsView.class],
        [[MASExampleViewController alloc] initWithTitle:@"Composite sides" viewClass:MASExampleSidesView.class],
    ];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
