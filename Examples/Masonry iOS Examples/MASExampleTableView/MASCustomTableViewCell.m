//
//  MASCustomTableViewCell.m
//  Masonry iOS Examples
//
//  Created by Jadian on 1/1/15.
//  Copyright (c) 2015 Jonas Budelmann. All rights reserved.
//

#import "MASCustomTableViewCell.h"

@implementation MASCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _height = 0;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
            [self.contentView makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.width.right.equalTo(self);
            }];
        }
    }
    
    return self;
}

- (void)setHeight:(CGFloat)height{
    _height = height;
    
    [self.contentView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
}

@end
