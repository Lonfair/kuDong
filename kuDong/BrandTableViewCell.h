//
//  BrandTableViewCell.h
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandCellModel.h"

@interface BrandTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *number;

-(void)initAllSubViews;
-(void)setContent:(BrandCellModel *)model;

@end
