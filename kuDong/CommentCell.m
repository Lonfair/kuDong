//
//  CommentCell.m
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "CommentCell.h"
#import "DetailViewController.h"

@implementation CommentCell

-(void)initAllSubViews
{
    
}

-(void)setContent:(CommentModel *)model
{
    [self.heaerView setImageWithURL:[NSURL URLWithString:model.user[@"avatar_small"]] placeholderImage:[UIImage imageNamed:@"user_icon.9.png"]];
    self.heaerView.layer.cornerRadius = self.heaerView.bounds.size.width/2;
    self.heaerView.clipsToBounds = YES;
    self.nameLabel.text = model.user[@"nickname"];
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:model.created_at];
    int timeInter = -(int)[createDate timeIntervalSinceNow];
    int second = timeInter;
    int minute = timeInter/60;
    int hour = timeInter/3600;
    int day = timeInter/86400;
    int month = timeInter/(86400*30);
    if (month >= 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d月前",month];
    }
    else if (day >= 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d天前",day];
    }
    else if (hour >= 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d小时前",hour];
    }
    else if (minute >= 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d分钟前",minute];
    }
    else if (second >= 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d秒前",second];
    }
    else{
        self.timeLabel.text = @"刚刚";
    }
    
    if(model.touser != nil){
    self.replyUserNameLabel.text = [NSString stringWithFormat:@"@%@",model.touser[@"nickname"]];
    }else
        self.replyUserNameLabel.text = @"";
    
    self.contentLabel.text = model.content;
}

-(void)addTapWithModel:(CommentModel *)model{
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    NSInteger userId1 = ((NSNumber *)model.user[@"id"]).integerValue;
    
    self.heaerView.tag = userId1;
    [self.heaerView addGestureRecognizer:headTap];
    
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    NSInteger userId2 = ((NSNumber *)model.user[@"id"]).integerValue;
    
    self.nameLabel.tag = userId2;
    [self.nameLabel addGestureRecognizer:nameTap];
    
    if(model.touser != nil){
    UITapGestureRecognizer *toUserTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    NSInteger toUserId = ((NSNumber *)model.touser[@"id"]).integerValue;
    
    self.replyUserNameLabel.tag = toUserId;
    [self.replyUserNameLabel addGestureRecognizer:toUserTap];
    }
}

-(void)userTapDeal:(UITapGestureRecognizer *)tap
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    NSInteger tag1 = tap.view.tag;
    vc.userID = [NSString stringWithFormat:@"%li",tag1];
    [_vc.navigationController pushViewController:vc animated:YES];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
