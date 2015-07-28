//
//  EventTableViewCell.m
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell


-(void)initAllSubViews{
    
}

-(void)setContent:(EventModel *)model{
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    self.headImageView.clipsToBounds = YES;
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"Popup_fail@2x.png"]];
    
    if(model.feeds.count >= 1){
    [self.firstImageView setImageWithURL:[NSURL URLWithString:model.feeds[0][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
    
     if(model.feeds.count >= 2){
     [self.secondImageView setImageWithURL:[NSURL URLWithString:model.feeds[1][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
      if(model.feeds.count >= 3){
      [self.thirdImageView setImageWithURL:[NSURL URLWithString:model.feeds[2][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
      }
     }
    }
    
    self.titleLabel.text = model.name;
    self.endLabel.text = model.enddate_str;
}

-(void)setBestManContent:(bestManModel *)model{
    
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    self.headImageView.clipsToBounds = YES;
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.avatar_small] placeholderImage:[UIImage imageNamed:@"Popup_fail@2x.png"]];
    
    if(model.feeds.count >= 1){
        [self.firstImageView setImageWithURL:[NSURL URLWithString:model.feeds[0][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
        
        if(model.feeds.count >= 2){
            [self.secondImageView setImageWithURL:[NSURL URLWithString:model.feeds[1][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            if(model.feeds.count >= 3){
                [self.thirdImageView setImageWithURL:[NSURL URLWithString:model.feeds[2][@"pic"][@"url_small"]] placeholderImage:[UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            }
        }
    }
    
    self.titleLabel.text = model.nickname;
    self.endLabel.text = model.desc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
