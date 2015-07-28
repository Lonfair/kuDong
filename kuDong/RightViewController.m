//
//  RightViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/15.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backGroungImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backGroungImage.image = [UIImage imageNamed:@"login_5s_bg01@2x.jpg"];
    [self.view addSubview:backGroungImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
