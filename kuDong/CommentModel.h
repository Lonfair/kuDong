//
//  CommentModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (copy,nonatomic) NSString *content;
@property (assign,nonatomic) NSTimeInterval created_at;
@property (copy,nonatomic) NSNumber *id;
@property (copy,nonatomic) NSString *thread_id;
@property (copy,nonatomic) NSMutableDictionary *user;
@property (copy,nonatomic) NSMutableDictionary *touser;

@end
