//
//  PhotoListCell.m
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "PhotoListCell.h"
#import "CustomDetailViewController.h"

@implementation PhotoListCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)addTap{
    if(_userID1){
    UITapGestureRecognizer *photoTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
        self.firstImage.tag = _userID1;
    [self.firstImage addGestureRecognizer:photoTap1];
    }
    if(_userID2){
        UITapGestureRecognizer *photoTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
        self.secondImage.tag = _userID2;
        [self.secondImage addGestureRecognizer:photoTap2];
    }
    if(_userID3){
        UITapGestureRecognizer *photoTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
        self.thirdImage.tag = _userID3;
        [self.thirdImage addGestureRecognizer:photoTap3];
    }
}

-(void)detailTapDeal:(UITapGestureRecognizer *)tap
{
    CustomDetailViewController *cvc = [[CustomDetailViewController alloc] init];
    cvc.userID = tap.view.tag;
    [_vc.navigationController pushViewController:cvc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
