//
//  PubCellModel.h
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubCellModel : NSObject

@property (nonatomic,copy) NSString *liked;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSMutableArray *tags;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic,copy) NSNumber *pic_height;
@property (nonatomic,copy) NSMutableArray *liked_users;
@property (nonatomic,copy) NSString *flag;
@property (nonatomic,copy) NSMutableDictionary *type;
@property (nonatomic,copy) NSString *tags_content;
@property (nonatomic,copy) NSString *is_pushed;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSMutableDictionary *user;
@property (nonatomic,copy) NSMutableDictionary *pic;
@property (nonatomic,copy) NSString *cat;
@property (nonatomic,copy) NSString *view_count;
@property (nonatomic,copy) NSMutableArray *comments;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSNumber *pic_width;
@property (nonatomic,copy) NSString *comment_count;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSMutableDictionary *video;

@end
