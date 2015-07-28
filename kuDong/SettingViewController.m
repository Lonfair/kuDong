//
//  SettingViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "SettingViewController.h"
#import "MySettingViewController.h"
#import "SecretViewController.h"
#import "PushViewController.h"
#import "DynamicNotificationViewController.h"
#import "AccountViewController.h"
#import "InviteFriendViewController.h"
#import "DetailModel.h"

@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    UIViewController *_suggestViewController;
}
@property (strong,nonatomic) DetailModel *model;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置界面";
    self.view.backgroundColor = [UIColor magentaColor];
    [self createUI];
}

-(void)createUI{
    _titleArray = [[NSArray alloc] init];
    _titleArray = @[@[@"隐私设置",@"推送设置",@"动态提醒设置",@"保存图片到相册"],@[@"账号绑定",@"邀请好友",@"清除缓存"],@[@"意见反馈",@"去GooglePlay打分",@"关于酷动"]];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    footView.userInteractionEnabled = YES;
    _tableView.tableFooterView = footView;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"退出登录" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelButton addTarget:self action:@selector(resignApp) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"NavNormal.png"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"NavHighLight.png"] forState:UIControlStateHighlighted];
    [footView addSubview:cancelButton];
    [cancelButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width).offset(-180);
        make.height.mas_equalTo(40);
    }];
   
    UILabel *label = [[UILabel alloc] init];
    [footView addSubview:label];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"version 1.1.1";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 4;
    }
    else
        return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"cell1";
    static NSString *cellID2 = @"cell2";
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        
        NSUserDefaults *userMessage = [NSUserDefaults standardUserDefaults];
        NSData *data = [userMessage objectForKey:@"userMessageConfig"];
        _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [cell.imageView setImageWithURL:[NSURL URLWithString:_model.avatar_small]];
        cell.imageView.layer.cornerRadius = 20;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.text = _model.nickname;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return cell;
    }
    else {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID2];
            cell.textLabel.text = _titleArray[indexPath.section - 1][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            if (indexPath.section == 1 && indexPath.row == 3) {
                UISwitch *swit = [[UISwitch alloc] initWithFrame:CGRectMake(10, 0, 60, 20)];
                [swit setOn:YES animated:YES];
                cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
                [cell.accessoryView addSubview:swit];
            }
        }
        
        
        
        
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        MySettingViewController *mvc = [[MySettingViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SecretViewController *svc = [[SecretViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
        if (indexPath.row == 1) {
            PushViewController *svc = [[PushViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
        if (indexPath.row == 2) {
            DynamicNotificationViewController *svc = [[DynamicNotificationViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            AccountViewController *svc = [[AccountViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
        if (indexPath.row == 1) {
            InviteFriendViewController *svc = [[InviteFriendViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
        if (indexPath.row == 2) {
            UIActionSheet *removeCahe = [[UIActionSheet alloc] initWithTitle:nil delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除缓存" otherButtonTitles:nil, nil];
            [removeCahe showInView:self.view];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            _suggestViewController = [[UIViewController alloc] init];
            _suggestViewController.title = @"意见反馈";
            _suggestViewController.view.backgroundColor = [UIColor lightGrayColor];
            UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(suggest)];
            _suggestViewController.navigationItem.rightBarButtonItem = rightBar;
            UITextView *textView1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, _suggestViewController.view.bounds.size.width, 200)];
            textView1.delegate = (id<UITextViewDelegate>)self;
            UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectMake(0, 250, _suggestViewController.view.bounds.size.width, 50)];
            textView2.delegate = (id<UITextViewDelegate>)self;
            [_suggestViewController.view addSubview:textView1];
            [_suggestViewController.view addSubview:textView2];
            textView1.text = @"请输入你的意见";
            textView1.font = [UIFont systemFontOfSize:18];
            textView1.textColor = [UIColor lightGrayColor];
            textView2.text = @"联系方式(电话,QQ或Email)";
            textView2.font = [UIFont systemFontOfSize:18];
            textView2.textColor = [UIColor lightGrayColor];
            [self.navigationController pushViewController:_suggestViewController animated:YES];
        }
        if(indexPath.row == 2){
            UIViewController *webVc = [[UIViewController alloc] init];
            UIWebView *web = [[UIWebView alloc] initWithFrame:webVc.view.bounds];
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kudong.im/about"]]];
            [webVc.view addSubview:web];
            [self.navigationController pushViewController:webVc animated:YES];
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
     NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"缓存清理" message: [NSString stringWithFormat:@"缓存文件%fM 确认清理吗",[self fileSizeAtPath:cachPath]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = (id<UIAlertViewDelegate>)self;
    alertView.tag = 100;
    [alertView show];
}

-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 100 && buttonIndex == 1){
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%ld",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    }
}

-(void)clearCacheSuccess
{
    UIAlertView *clearCacheView = [[UIAlertView alloc] initWithTitle:nil message:@"清理成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [clearCacheView show];
}

-(void)suggest{
    [_suggestViewController.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{
    textView.text = @"";
    textView.font = [UIFont systemFontOfSize:20];
    textView.textColor = [UIColor blackColor];
}

-(void)resignApp{
    UIApplication *app = (UIApplication *)[UIApplication sharedApplication];
    [app.delegate application:app didFinishLaunchingWithOptions:nil];
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
