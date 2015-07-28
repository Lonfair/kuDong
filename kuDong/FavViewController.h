//
//  FavViewController.h
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "RootViewController.h"
#import "FavModel.h"

@interface FavViewController : RootViewController
@property (retain,nonatomic) NSMutableArray *myFavIdArray;
@property (retain,nonatomic) NSMutableDictionary *myFavDict;
@property (weak,nonatomic) void (^changeFav)(NSMutableArray *myFavIdArray);
@end
