//
//  PubTableViewCellNew.m
//  kuDong
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "PubTableViewCellNew.h"
#import "CommonListViewController.h"
#import "DetailViewController.h"
#import "CustomDetailViewController.h"

@implementation PubTableViewCellNew

-(void)setContent:(PubCellModel *)model
{
    [self.photoImageView setImageWithURL:[NSURL URLWithString:model.pic[@"url"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
//    for (UIView *view1 in self.photoImageView.subviews) {
//        [view1 removeFromSuperview];
//    }

//    if(model.video != nil && _vedioPlayer == nil){
//        self.vedioPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:model.video[@"url"]]];
//        self.vedioPlayer.view.frame = self.photoImageView.bounds;
////        NSLog(@"sdffsdf = %@",_vedioPlayer.view.bounds);
//        [self.photoImageView addSubview:self.vedioPlayer.view];
//        [self.vedioPlayer prepareToPlay];
//    }

    [self.headerImageView setImageWithURL:[NSURL URLWithString:model.user[@"avatar_small"]] placeholderImage:[UIImage imageNamed:@"portrait_80.png"]];
    self.nameLabel.text = model.user[@"nickname"];
    self.topicLabel.text = model.type[@"name"];
    self.pubTimeLabel.text = model.created_at;
    self.contentLabel.text = model.content;
    
    if(model.tags.count >= 1){
        self.extraTopicLabel1.text =[NSString stringWithFormat:@"# %@",model.tags[0][@"name"]];
        [self.extraTopicLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
        }];
        self.extraTopicLabel1.font = [UIFont systemFontOfSize:17];
        [self.extraTopicLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
        }];
        self.extraTopicLabel2.font = [UIFont systemFontOfSize:17];
        [self.extraTopicLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
        }];
        self.extraTopicLabel3.font = [UIFont systemFontOfSize:17];
        if(model.tags.count >= 2){
            self.extraTopicLabel2.text = [NSString stringWithFormat:@"# %@",model.tags[1][@"name"]];
            
            if(model.tags.count >= 3){
                self.extraTopicLabel3.text = [NSString stringWithFormat:@"# %@",model.tags[2][@"name"]];
                
            }
        }
    }
    
    self.heartLabel.text = ((NSNumber *)model.like_count).stringValue;
    self.commentLabel.text = ((NSNumber *)model.comment_count).stringValue;
    
    if (model.liked_users.count >= 1) {
        [self.fansHeaderImage1 setImageWithURL:[NSURL URLWithString:model.liked_users[model.liked_users.count-1][@"avatar_small"]]];
        if (model.liked_users.count >= 2) {
            [self.fansHeaderImage2 setImageWithURL:[NSURL URLWithString:model.liked_users[model.liked_users.count-2][@"avatar_small"]]];
            if (model.liked_users.count >= 3) {
                [self.fansHeaderImage3 setImageWithURL:[NSURL URLWithString:model.liked_users[model.liked_users.count-3][@"avatar_small"]]];
                if (model.liked_users.count >= 4) {
                    [self.fansHeaderImage4 setImageWithURL:[NSURL URLWithString:model.liked_users[model.liked_users.count-4][@"avatar_small"]]];
                    if (model.liked_users.count >= 5) {
                        [self.fansHeaderImage5 setImageWithURL:[NSURL URLWithString:model.liked_users[model.liked_users.count-5][@"avatar_small"]]];
                    }
                }
            }
        }
    }
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((model.content.length/21 +1)*26);
    }];
    self.contentLabel.font = [UIFont systemFontOfSize:17];
    
    if (model.comments.count >= 1) {
        self.commentFans1.text = model.comments[model.comments.count - 1][@"user"][@"nickname"];
        self.commentContent1.text = model.comments[model.comments.count - 1][@"content"];
        [self.commentFans1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
        }];
        self.commentFans1.font = [UIFont systemFontOfSize:17];
        
        [self.commentContent1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
        }];
        self.commentContent1.font = [UIFont systemFontOfSize:17];
        
        if (model.comments.count >= 2) {
            self.commentFans2.text = model.comments[model.comments.count - 2][@"user"][@"nickname"];
            self.commentContent2.text = model.comments[model.comments.count - 2][@"content"];
            [self.commentFans2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(26);
            }];
            self.commentFans2.font = [UIFont systemFontOfSize:17];
            [self.commentContent2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(26);
            }];
            self.commentContent2.font = [UIFont systemFontOfSize:17];
            if (model.comments.count >= 3) {
                
                self.commentFans3.text = model.comments[model.comments.count - 3][@"user"][@"nickname"];
                self.commentContent3.text = model.comments[model.comments.count - 3][@"content"];
                
                [self.commentFans3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(26);
                }];
                [self.commentContent3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(26);
                }];
                
                self.commentFans3.font = [UIFont systemFontOfSize:17];
                self.commentContent3.font = [UIFont systemFontOfSize:17];
                
            }
        }
    }

}

-(void)initAllSubViews
{
    _headerImageView.layer.cornerRadius = _headerImageView.frame.size.width/2;
    _headerImageView.clipsToBounds = YES;
    _fansHeaderImage2.layer.cornerRadius = _fansHeaderImage2.frame.size.width/2;
    _fansHeaderImage2.clipsToBounds = YES;
    _fansHeaderImage3.layer.cornerRadius = _fansHeaderImage3.frame.size.width/2;
    _fansHeaderImage3.clipsToBounds = YES;
    _fansHeaderImage4.layer.cornerRadius = _fansHeaderImage4.frame.size.width/2;
    _fansHeaderImage4.clipsToBounds = YES;
    _fansHeaderImage5.layer.cornerRadius = _fansHeaderImage5.frame.size.width/2;
    _fansHeaderImage5.clipsToBounds = YES;
    _fansHeaderImage1.layer.cornerRadius = _fansHeaderImage1.frame.size.width/2;
    _fansHeaderImage1.clipsToBounds = YES;
    
    _contentLabel.numberOfLines = 0;
    _extraTopicLabel1.numberOfLines = 0;
    _extraTopicLabel2.numberOfLines = 0;
    _extraTopicLabel3.numberOfLines = 0;
    
    _commentFans1.numberOfLines = 0;
    _commentContent1.numberOfLines = 0;
    _commentFans2.numberOfLines = 0;
    _commentContent2.numberOfLines = 0;
    _commentFans3.numberOfLines = 0;
    _commentContent3.numberOfLines = 0;
  
    _contentLabel.text = @"";
    _extraTopicLabel1.text = @"";
    _extraTopicLabel2.text = @"";
    _extraTopicLabel3.text = @"";
    _commentFans1.text = @"";
    _commentFans2.text = @"";
    _commentFans3.text = @"";
    _commentContent1.text = @"";
    _commentContent2.text = @"";
    _commentContent3.text = @"";
    
    [self setNeedsUpdateConstraints];
   
}

-(void)addTapWithModel:(PubCellModel *)model{
    UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
    self.commentImageView.tag = model.id.integerValue;
    [self.commentImageView addGestureRecognizer:commentTap];
    
    UITapGestureRecognizer *bottomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
    self.bottomCommentView.tag = model.id.integerValue;
    [self.bottomCommentView addGestureRecognizer:bottomTap];
    
    UITapGestureRecognizer *userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    NSInteger ide = ((NSNumber *)model.user[@"id"]).integerValue;
    self.headerImageView.tag = ide;
    [self.headerImageView addGestureRecognizer:userTap];

    
    UITapGestureRecognizer *topicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicTapDeal:)];
    NSInteger ide1 = ((NSNumber *)model.type[@"id"]).integerValue;
    self.topicLabel.tag = ide1;
    [self.topicLabel addGestureRecognizer:topicTap];
    
    
    if (model.liked_users.count >= 1) {
        UITapGestureRecognizer *fansTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
        NSInteger fans1 = ((NSNumber *)model.liked_users[model.liked_users.count-1][@"id"]).integerValue;
        self.fansHeaderImage1.tag = fans1;
        [self.fansHeaderImage1 addGestureRecognizer:fansTap1];
    if (model.liked_users.count >= 2) {
        UITapGestureRecognizer *fansTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
        NSInteger fans2 = ((NSNumber *)model.liked_users[model.liked_users.count-2][@"id"]).integerValue;
        self.fansHeaderImage2.tag = fans2;
        [self.fansHeaderImage2 addGestureRecognizer:fansTap2];
        
        if (model.liked_users.count >= 3) {
            UITapGestureRecognizer *fansTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
            NSInteger fans3 = ((NSNumber *)model.liked_users[model.liked_users.count-3][@"id"]).integerValue;
            self.fansHeaderImage3.tag = fans3;
            [self.fansHeaderImage3 addGestureRecognizer:fansTap3];
            
            if (model.liked_users.count >= 4) {
                UITapGestureRecognizer *fansTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
                NSInteger fans4 = ((NSNumber *)model.liked_users[model.liked_users.count-4][@"id"]).integerValue;
                self.fansHeaderImage4.tag = fans4;
                [self.fansHeaderImage4 addGestureRecognizer:fansTap4];
                
                if (model.liked_users.count >= 5) {
                    UITapGestureRecognizer *fansTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
                    NSInteger fans5 = ((NSNumber *)model.liked_users[model.liked_users.count-5][@"id"]).integerValue;
                    self.fansHeaderImage5.tag = fans5;
                    [self.fansHeaderImage5 addGestureRecognizer:fansTap5];
                    
                }
             }
          }
       }
    }



 if (model.comments.count >= 1) {
    UITapGestureRecognizer *commentTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    NSInteger comments1 = ((NSNumber *)model.comments[model.comments.count-1][@"user"][@"id"]).integerValue;
    self.commentFans1.tag = comments1;
    [self.commentFans1 addGestureRecognizer:commentTap1];
    
    if (model.comments.count >= 2) {
        UITapGestureRecognizer *commentTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
        NSInteger comments2 = ((NSNumber *)model.comments[model.comments.count-2][@"user"][@"id"]).integerValue;
        
        self.commentFans2.tag = comments2;
        [self.commentFans2 addGestureRecognizer:commentTap2];
        
        if (model.comments.count >= 3) {
            UITapGestureRecognizer *commentTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
            NSInteger comments3 = ((NSNumber *)model.comments[model.comments.count-3][@"user"][@"id"]).integerValue;
            self.commentFans3.tag = comments3;
            [self.commentFans3 addGestureRecognizer:commentTap3];
            
             }
          }
       }
    
    if (model.tags.count >= 1) {
        UITapGestureRecognizer *extraTagTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicTapDeal:)];
        NSInteger extra1 = ((NSNumber *)model.tags[0][@"id"]).integerValue;
        self.extraTopicLabel1.tag = extra1;
        [self.extraTopicLabel1 addGestureRecognizer:extraTagTap1];
        
        if (model.tags.count >= 2) {
            UITapGestureRecognizer *extraTagTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicTapDeal:)];
            NSInteger extra2 = ((NSNumber *)model.tags[1][@"id"]).integerValue;
            self.extraTopicLabel2.tag = extra2;
            [self.extraTopicLabel2 addGestureRecognizer:extraTagTap2];
            
            if (model.tags.count >= 3) {
                UITapGestureRecognizer *extraTagTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicTapDeal:)];
                NSInteger extra3 = ((NSNumber *)model.tags[2][@"id"]).integerValue;
                self.extraTopicLabel3.tag = extra3;
                [self.extraTopicLabel3 addGestureRecognizer:extraTagTap3];
                
            }
        }
    }
    
    UITapGestureRecognizer *vedioTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vedioTapDeal:)];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:vedioTap];

}

-(void)vedioTapDeal:(UITapGestureRecognizer *)tap{

    [self.delegate vedioTapDeal:tap];
//    [_vedioPlayer play];
}

-(void)topicTapDeal:(UITapGestureRecognizer *)tap{
    CommonListViewController *vc = [[CommonListViewController alloc] init];
    NSInteger tag1 = tap.view.tag;
    vc.topicID = tag1;
    [_vc.navigationController pushViewController:vc animated:YES];
}

-(void)userTapDeal:(UITapGestureRecognizer *)tap
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    NSInteger tag1 = tap.view.tag;
    vc.userID = [NSString stringWithFormat:@"%li",tag1];
    [_vc.navigationController pushViewController:vc animated:YES];
}

-(void)detailTapDeal:(UITapGestureRecognizer *)tap
{
    CustomDetailViewController *cvc = [[CustomDetailViewController alloc] init];
    cvc.userID = tap.view.tag;
    [_vc.navigationController pushViewController:cvc animated:YES];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
