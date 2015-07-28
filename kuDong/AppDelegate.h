//
//  AppDelegate.h
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) DDMenuController *menuController;
-(void)loginFrontView;
@end

