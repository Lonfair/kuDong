//
//  HeaderView.h
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIImageView

@property (strong,nonatomic) UIImageView *headImageView;
@property (strong,nonatomic) UILabel *placeLabel;
@property (strong,nonatomic) UIImageView *photoImageView;
@property (strong,nonatomic) UILabel *photoLabelNumber;
@property (strong,nonatomic) UILabel *photoLabelTitle;
@property (strong,nonatomic) UIImageView *fansImageView;
@property (strong,nonatomic) UILabel *fansLabelTitle;
@property (strong,nonatomic) UILabel *fansLabelNumber;
@property (strong,nonatomic) UIImageView *focusImageView;
@property (strong,nonatomic) UILabel *focusLabelTitle;
@property (strong,nonatomic) UILabel *focusLabelNumber;
@property (strong,nonatomic) UIImageView *myFocusImageView;
@property (strong,nonatomic) UILabel *myFocusLabelStatus;
@property (strong,nonatomic) UISegmentedControl *segmentControl;
@end
