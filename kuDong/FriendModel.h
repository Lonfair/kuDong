//
//  FriendModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/13.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property (copy,nonatomic) NSMutableDictionary *byuser;
@property (copy,nonatomic) NSString *content;
@property (assign,nonatomic) double created_at;
@property (copy,nonatomic) NSString *id;
@property (copy,nonatomic) NSString *is_read;
@property (copy,nonatomic) NSMutableArray *pics;
@property (copy,nonatomic) NSString *sub_content;
@property (copy,nonatomic) NSString *type;

@end
