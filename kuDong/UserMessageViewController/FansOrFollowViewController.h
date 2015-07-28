//
//  FansOrFollowViewController.h
//  kuDong
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "RootViewController.h"

typedef NS_OPTIONS(NSUInteger, FansOrFollow) {
    UserFans   = 0,
    UserFollow = 1,
};
@interface FansOrFollowViewController : RootViewController

@property (copy,nonatomic) NSString *userID;
@property (assign,nonatomic) FansOrFollow fansOrFollow;
@end
