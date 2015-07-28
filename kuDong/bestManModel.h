//
//  bestManModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/15.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bestManModel : NSObject
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *avatar_small;
@property (nonatomic,copy) NSString *feed_count;
@property (nonatomic,copy) NSString *verify;
@property (nonatomic,copy) NSString *follow_count;
@property (nonatomic,copy) NSString *fans_count;
@property (nonatomic,copy) NSString *album_count;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSMutableDictionary *config;
@property (nonatomic,copy) NSString *medal;
@property (nonatomic,copy) NSString *relationship;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSMutableArray *feeds;

@end
