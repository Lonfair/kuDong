//
//  AppDelegate.m
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "RightViewController.h"
#import "MainViewController.h"
#import "DetailViewController.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
#import "UIView+ZJQuickControl.h"
#import "DetailModel.h"

@interface AppDelegate () <UIScrollViewDelegate>
{
    UIPageControl *_pageIndicator;
    UIViewController *_loginVc;
    NSArray *_loginTypes;
}
@property (strong,nonatomic) UIImageView *headImageView;
@property (strong,nonatomic) UILabel *usernameLabel;
@property (copy,nonatomic) NSString *loginType;
@property (strong,nonatomic) DetailModel *userMessageModel;
@end

@implementation AppDelegate
@synthesize window = _window;
@synthesize menuController = _menuController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor orangeColor];
    [self.window makeKeyAndVisible];
    [self loginFrontView];
    return YES;
}

-(void)loginFrontView{
    _loginVc = [[UIViewController alloc] init];
    self.window.rootViewController = _loginVc;
    
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    [_loginVc.view addSubview:scrollerView];
    scrollerView.contentSize = CGSizeMake(self.window.bounds.size.width * 4, self.window.bounds.size.height);
    scrollerView.bounces = NO;
    scrollerView.pagingEnabled = YES;
    scrollerView.delegate = self;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.showsVerticalScrollIndicator = NO;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"login_bg0%i.png",i+1]]];
        imageView.frame = CGRectMake(self.window.bounds.size.width*i, 0, self.window.bounds.size.width, self.window.bounds.size.height);
        [scrollerView addSubview:imageView];
    }
    _pageIndicator = [[UIPageControl alloc] init];
    _pageIndicator.numberOfPages = 4;
    [_loginVc.view addSubview:_pageIndicator];
    [_pageIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_loginVc.view.mas_centerX);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    NSArray *images = @[@"share_weibo_icon@2x.png",@"share_weixin_icon@2x.png"];
    _loginTypes = @[UMShareToSina,UMShareToWechatSession];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [_loginVc.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(90+120*i);
            make.bottom.mas_equalTo(-60);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(60);
        }];
        
        button.tag = 100+i;
        [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [UMSocialData setAppKey:@"559e17c567e58e162d002c0f"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
}

-(void)jumpToMainView{
    MainViewController *mainController = [[MainViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navController];
    _menuController = rootController;
    
    LeftMenuViewController *leftController = [[LeftMenuViewController alloc] init];
    RightViewController *rightViewController = [[RightViewController alloc] init];
    rootController.leftViewController = leftController;
    rootController.rightViewController = rightViewController;
    [rootController addChildViewController:leftController];
    [rootController addChildViewController:rightViewController];
    [rootController addChildViewController:navController];
    leftController.menuController = rootController;
    
    self.window.rootViewController = rootController;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageIndicator.currentPage = scrollView.contentOffset.x/self.window.bounds.size.width;
}

-(void)loginAction:(UIButton *)button
{
    [self jumpToMainView];
    self.loginType = _loginTypes[button.tag-100];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:self.loginType];
    
    snsPlatform.loginClickHandler(_loginVc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //A.显示基本信息
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:self.loginType];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager POST:@"http://ledong.im/api/user/oauth_login" parameters:@{@"auto_follow":@"1",@"token":snsAccount.accessToken,@"uid":snsAccount.usid,@"type":@"weibo"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                _userMessageModel = [[DetailModel alloc] init];
                [_userMessageModel setValuesForKeysWithDictionary:dict[@"data"]];
                
                NSData *userMessageConfig = [NSKeyedArchiver archivedDataWithRootObject:_userMessageModel];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:userMessageConfig forKey:@"userMessageConfig"];
                
                [self jumpToMainView];
                
                NSLog(@"登陆成功返回 = %@",dict);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"POST Login 失败");
            }];
            
//            [self.headImageView setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];
//            self.usernameLabel.text = snsAccount.userName;
            
            //B.显示用户信息
            //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                
                NSLog(@"SnsInformation is %@",response.data);
                
            }];
            
            
        }});
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
