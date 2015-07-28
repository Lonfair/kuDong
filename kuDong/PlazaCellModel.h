//
//  PlazaCellModel.h
//  kuDong
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlazaCellModel : NSObject

@property (copy,nonatomic) NSMutableArray *feeds;
@property (copy,nonatomic) NSNumber* id;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *old_name;
@property (copy,nonatomic) NSString *title;
@end
