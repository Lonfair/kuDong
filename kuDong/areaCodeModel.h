//
//  areaCodeModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/13.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaCodeModel : NSObject
@property (copy,nonatomic) NSString *displayorder;
@property (copy,nonatomic) NSString *geohash;
@property (copy,nonatomic) NSString *id;
@property (copy,nonatomic) NSString *is_hidden;
@property (copy,nonatomic) NSString *is_hot;
@property (copy,nonatomic) NSString *level;
@property (copy,nonatomic) NSString *name;
@property (assign,nonatomic) BOOL *parent_id;
@property (copy,nonatomic) NSString *pinyin;
@property (copy,nonatomic) NSMutableArray *cities;
@end
