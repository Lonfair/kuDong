//
//  PubTableViewCellNew.h
//  kuDong
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PubCellModel.h"

@protocol pubCellDelegate <NSObject>

-(void)vedioTapDeal:(UITapGestureRecognizer *)tap;

@end

@interface PubTableViewCellNew : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *extraTopicLabel1;
@property (weak, nonatomic) IBOutlet UILabel *extraTopicLabel2;
@property (weak, nonatomic) IBOutlet UILabel *extraTopicLabel3;
@property (weak, nonatomic) IBOutlet UIView *saporretedLine1;
@property (weak, nonatomic) IBOutlet UIView *saporretedLine2;
@property (weak, nonatomic) IBOutlet UIImageView *fansHeaderImage1;
@property (weak, nonatomic) IBOutlet UIImageView *fansHeaderImage2;
@property (weak, nonatomic) IBOutlet UIImageView *fansHeaderImage3;
@property (weak, nonatomic) IBOutlet UIImageView *fansHeaderImage4;
@property (weak, nonatomic) IBOutlet UIImageView *fansHeaderImage5;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImage;
@property (weak, nonatomic) IBOutlet UILabel *heartLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomCommentView;
@property (weak, nonatomic) IBOutlet UILabel *commentFans1;
@property (weak, nonatomic) IBOutlet UILabel *commentFans2;
@property (weak, nonatomic) IBOutlet UILabel *commentFans3;
@property (weak, nonatomic) IBOutlet UILabel *commentContent1;
@property (weak, nonatomic) IBOutlet UILabel *commentContent2;
@property (weak, nonatomic) IBOutlet UILabel *commentContent3;
@property (weak,nonatomic) UIViewController *vc;

@property (strong,nonatomic) MPMoviePlayerController *vedioPlayer;
@property (weak,nonatomic) PubCellModel *model;

@property (nonatomic,weak)id<pubCellDelegate> delegate;
-(void)initAllSubViews;
-(void)setContent:(PubCellModel *)model;
-(void)addTapWithModel:(PubCellModel *)model;
@end
