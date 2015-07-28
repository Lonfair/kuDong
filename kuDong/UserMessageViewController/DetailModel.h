//
//  DetailModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject <NSCoding>

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *avatar_small;
@property (nonatomic,copy) NSNumber *feed_count;
@property (nonatomic,copy) NSString *verify;
@property (nonatomic,copy) NSNumber *follow_count;
@property (nonatomic,copy) NSNumber *fans_count;
@property (nonatomic,copy) NSString *album_count;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSDictionary *area;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSDictionary *config;
@property (nonatomic,copy) NSString *medal;
@property (nonatomic,copy) NSDictionary *data;
@property (nonatomic,copy) NSArray *fav;
@property (nonatomic,copy) NSString *relationship;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *easemob_password;
@property (nonatomic,copy) NSString *is_register;
@property (nonatomic,copy) NSString *weibo_guide;

@end
