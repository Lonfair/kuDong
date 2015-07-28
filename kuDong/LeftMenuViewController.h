//
//  LeftMenuViewController.h
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "RootViewController.h"
#import "DetailModel.h"
#import "DDMenuController.h"

@interface LeftMenuViewController : RootViewController

@property (strong,nonatomic) DetailModel *model;
@property (weak,nonatomic) DDMenuController *menuController;
@end
