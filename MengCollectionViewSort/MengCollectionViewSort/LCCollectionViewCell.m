//
//  LCCollectionViewCell.m
//  MengCollectionViewSort
//
//  Created by menglingchao on 2019/12/25.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "LCCollectionViewCell.h"
#import "Masonry.h"

@implementation LCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self titleLabel];
    }
    return self;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.text = @"";
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return _titleLabel;
}

@end
