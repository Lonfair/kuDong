//
//  BrandTableViewCell.m
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

-(void)initAllSubViews{
    
}

-(void)setContent:(BrandCellModel *)model{
    [self.logoImageView setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
    self.name.text = model.name;
    self.state.text = model.country;
    self.number.text = model.count.stringValue;
    self.category.text = model.types;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
