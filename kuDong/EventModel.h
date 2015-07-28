//
//  EventModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject
@property (nonatomic,copy) NSString *join_type;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *count_str;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *jumpurl;
@property (nonatomic,copy) NSString *enddate_str;
@property (nonatomic,copy) NSString *type_str;
@property (nonatomic,copy) NSString *date_str;
@property (nonatomic,copy) NSString *button;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *enddate;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSMutableArray *feeds;
@property (nonatomic,copy) NSString *has_tab;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *website;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *comment_count;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *description;
@end
