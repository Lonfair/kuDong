//
//  PhotoListCell.h
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubCellModel.h"

@interface PhotoListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak,nonatomic) UIViewController *vc;
@property (assign,nonatomic) NSInteger userID1;
@property (assign,nonatomic) NSInteger userID2;
@property (assign,nonatomic) NSInteger userID3;

-(void)addTap;

@end
