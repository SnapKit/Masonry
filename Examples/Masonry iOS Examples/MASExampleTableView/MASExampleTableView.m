//
//  MASExampleTableView.m
//  Masonry iOS Examples
//
//  Created by Jadian on 1/1/15.
//  Copyright (c) 2015 Jonas Budelmann. All rights reserved.
//

#import "MASExampleTableView.h"

#import "MASCustomTableViewCell.h"

#define TOTAL_ROW_COUNT 10

@interface MASExampleTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *colorAry;

@end

@implementation MASExampleTableView

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _tableView = [UITableView new];
    [self addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[MASCustomTableViewCell class] forCellReuseIdentifier:@"CustomCell"];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    
    _colorAry = [NSMutableArray new];
    for (int i = 0; i < TOTAL_ROW_COUNT; i++) {
        [_colorAry addObject:[self randomColor]];
    }
    
    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark - Table Deleaget

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TOTAL_ROW_COUNT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MASCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    cell.height = indexPath.row * 40;
    
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MASCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    cell.backgroundColor = _colorAry[indexPath.row];
    cell.height = indexPath.row * 40;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

@end
