//
//  AdvertisementTableViewCell.m
//  ADTest
//
//  Created by HUMioo on 2018/6/6.
//  Copyright © 2018 HUMiooZcs. All rights reserved.
//

#import "AdvertisementTableViewCell.h"
@interface AdvertisementTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation AdvertisementTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self createLayout];
    }
    return self;
}
- (void)setModel:(AdvertisementModel *)model {
    ///根据编辑状态变化
    if (model.isShow) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.nameLabel.text = @"";
    }else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.nameLabel.text = model.name;
    }
}
- (void)createLayout {
    self.nameLabel = [UILabel new];
    self.nameLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    self.nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
