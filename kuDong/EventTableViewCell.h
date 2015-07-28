//
//  EventTableViewCell.h
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
#import "bestManModel.h"

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

-(void)initAllSubViews;
-(void)setContent:(EventModel *)model;
-(void)setBestManContent:(bestManModel *)model;

@end