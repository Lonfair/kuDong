//
//  HeaderView.m
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        float Ritio = frame.size.width/320;
        [self createUIWithRitio:Ritio];
    }
    return self;
}

-(void)createUIWithRitio:(float)Ritio
{
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 80*Ritio/2;
    _headImageView.clipsToBounds = YES;
    [self addSubview:_headImageView];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(Ritio*20);
        make.top.mas_equalTo(self.mas_top).offset(Ritio*40);
        make.width.mas_equalTo(Ritio*80);
        make.height.mas_equalTo(Ritio*80);
        
    }];
    
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.textAlignment = NSTextAlignmentCenter;
    _placeLabel.textColor = [UIColor whiteColor];
    _placeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_bottom).offset(Ritio*5);
        make.centerX.mas_equalTo(_headImageView.mas_centerX);
        make.width.mas_equalTo(Ritio*80);
        make.height.mas_equalTo(Ritio*20);
    }];
    
    _photoImageView = [[UIImageView alloc] init];
    [self addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_top);
        make.left.mas_equalTo(_headImageView.mas_right).offset(-20*Ritio);
        make.width.mas_equalTo(Ritio*70);
        make.height.mas_equalTo(Ritio*50);
    }];
    
    _photoLabelNumber = [[UILabel alloc] init];
    _photoLabelTitle  = [[UILabel alloc] init];
    _photoLabelNumber.textAlignment = NSTextAlignmentCenter;
    _photoLabelNumber.textColor = [UIColor whiteColor];
    _photoLabelNumber.font = [UIFont systemFontOfSize:22];
    _photoLabelNumber.text = @"照片";
    _photoLabelTitle.textAlignment = NSTextAlignmentCenter;
    _photoLabelTitle.textColor = [UIColor whiteColor];
    _photoLabelTitle.font = [UIFont systemFontOfSize:22];
    [_photoImageView addSubview:_photoLabelNumber];
    [_photoImageView addSubview:_photoLabelTitle];
    [_photoLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_photoImageView.mas_top).offset(3*Ritio);
        make.centerX.mas_equalTo(_photoImageView.mas_centerX);
        make.width.mas_equalTo(_photoImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    [_photoLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_photoImageView.mas_bottom).offset(-3*Ritio);
        make.centerX.mas_equalTo(_photoImageView.mas_centerX);
        make.width.mas_equalTo(_photoImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    
    _fansImageView = [[UIImageView alloc] init];
    [self addSubview:_fansImageView];
    [_fansImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_top);
        make.left.mas_equalTo(_photoImageView.mas_right).offset(5*Ritio);
        make.width.mas_equalTo(Ritio*70);
        make.height.mas_equalTo(Ritio*50);
    }];
    _fansLabelTitle = [[UILabel alloc] init];
    _fansLabelNumber = [[UILabel alloc] init];

    _fansLabelTitle.textAlignment = NSTextAlignmentCenter;
    _fansLabelTitle.textColor = [UIColor whiteColor];
    _fansLabelTitle.font = [UIFont systemFontOfSize:22];
    _fansLabelNumber.textAlignment = NSTextAlignmentCenter;
    _fansLabelNumber.textColor = [UIColor whiteColor];
    _fansLabelNumber.font = [UIFont systemFontOfSize:22];
    _fansLabelNumber.text = @"粉丝";
    [_fansImageView addSubview:_fansLabelNumber];
    [_fansImageView addSubview:_fansLabelTitle];
    [_fansLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fansImageView.mas_top).offset(3*Ritio);
        make.centerX.mas_equalTo(_fansImageView.mas_centerX);
        make.width.mas_equalTo(_fansImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    [_fansLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_fansImageView.mas_bottom).offset(-3*Ritio);
        make.centerX.mas_equalTo(_fansImageView.mas_centerX);
        make.width.mas_equalTo(_fansImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    
    _focusImageView = [[UIImageView alloc] init];
    [self addSubview:_focusImageView];
    [_focusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_top);
        make.left.mas_equalTo(_fansImageView.mas_right).offset(5*Ritio);
        make.width.mas_equalTo(Ritio*70);
        make.height.mas_equalTo(Ritio*50);
    }];
    
    _focusLabelTitle = [[UILabel alloc] init];
    _focusLabelNumber = [[UILabel alloc] init];
    _focusLabelTitle.textAlignment = NSTextAlignmentCenter;
    _focusLabelTitle.textColor = [UIColor whiteColor];
    _focusLabelTitle.font = [UIFont systemFontOfSize:22];
    _focusLabelNumber.textAlignment = NSTextAlignmentCenter;
    _focusLabelNumber.textColor = [UIColor whiteColor];
    _focusLabelNumber.font = [UIFont systemFontOfSize:22];
    _focusLabelNumber.text = @"关注";
    [_focusImageView addSubview:_focusLabelNumber];
    [_focusImageView addSubview:_focusLabelTitle];
    [_focusLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_focusImageView.mas_top).offset(3*Ritio);
        make.centerX.mas_equalTo(_focusImageView.mas_centerX);
        make.width.mas_equalTo(_focusImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    [_focusLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_focusImageView.mas_bottom).offset(-3*Ritio);
        make.centerX.mas_equalTo(_focusImageView.mas_centerX);
        make.width.mas_equalTo(_focusImageView.mas_width).offset(-20);
        make.height.mas_equalTo(Ritio*20);
    }];
    
    
    
    _myFocusImageView = [[UIImageView alloc] init];
    [self addSubview:_myFocusImageView];
    _myFocusImageView.layer.cornerRadius = 5;
    _myFocusImageView.clipsToBounds = YES;
    [_myFocusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fansImageView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(_fansImageView.mas_centerX);
        make.width.mas_equalTo(180*Ritio);
        make.height.mas_equalTo(30*Ritio);
    }];
    
    _myFocusLabelStatus = [[UILabel alloc] init];
    _myFocusLabelStatus.textAlignment = NSTextAlignmentCenter;
    _myFocusLabelStatus.textColor = [UIColor whiteColor];
    _myFocusLabelStatus.font = [UIFont systemFontOfSize:20];
    _myFocusLabelStatus.text = @"编辑个人资料";
    [_myFocusImageView addSubview:_myFocusLabelStatus];
    [_myFocusLabelStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_myFocusImageView.mas_centerX);
        make.centerY.mas_equalTo(_myFocusImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    _headImageView.backgroundColor = [UIColor lightGrayColor];
    _photoImageView.backgroundColor = [UIColor darkGrayColor];
    _fansImageView.backgroundColor = [UIColor darkGrayColor];;
    _focusImageView.backgroundColor = [UIColor darkGrayColor];;
    _myFocusImageView.backgroundColor = [UIColor lightGrayColor];
    
    
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[[UIImage imageNamed:@"tab_profile_feed_info_h.png"],[UIImage imageNamed:@"tab_profile_feed_list_h.png"],[UIImage imageNamed:@"tab_profile_feed_grid_h.png"]]];
    _segmentControl.tintColor = [UIColor whiteColor];
    //    segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [self addSubview:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(40*Ritio);
    }];
    
    self.backgroundColor = [UIColor darkGrayColor];
}

@end
