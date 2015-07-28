//
//  CommentCell.h
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heaerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyUserNameLabel;
@property (weak,nonatomic) UIViewController *vc;
-(void)initAllSubViews;
-(void)setContent:(CommentModel *)model;
-(void)addTapWithModel:(CommentModel *)model;
@end
