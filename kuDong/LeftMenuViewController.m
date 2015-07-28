//
//  LeftMenuViewController.m
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "FriendViewController.h"
#import "AddFriendViewController.h"
#import "SettingViewController.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import "PlazaViewController.h"

@interface LeftMenuViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_iconImageArray;
    NSArray *_titleArray;
}
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createUI];
    [self downLoadMyData];
}

-(void)downLoadMyData{
    _model = [[DetailModel alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [manager GET:MyuserMessage parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        [_model setValuesForKeysWithDictionary:dict[@"data"]];
//       NSData *userMessageConfig = [NSKeyedArchiver archivedDataWithRootObject:_model];
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        [user setObject:userMessageConfig forKey:@"userMessageConfig"];
//      [_tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    }];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"userMessageConfig"];
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"name = %@,ID = %@",_model.nickname,_model.id);
}

-(void)createUI{
    _iconImageArray = @[[UIImage imageNamed:@"sidebar_home_h.png"],[UIImage imageNamed:@"sidebar_discover_h.png"],[UIImage imageNamed:@"sidebar_dynamic_h.png"],[UIImage imageNamed:@"sidebar_add_h.png"],[UIImage imageNamed:@"sidebar_setting_h.png"]];
    _titleArray = @[@"首页",@"广场",@"好友动态",@"添加好友",@"设置"];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.scrollEnabled = NO;
    _tableView.rowHeight = 60;
    
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.row == 0) {
        UIImageView *myHeadView = [[UIImageView alloc] init];
        [cell.contentView addSubview:myHeadView];
        [myHeadView setImageWithURL:[NSURL URLWithString:_model.avatar_small] placeholderImage:[UIImage imageNamed:@"user_icon.9.png"]];
       
        [myHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(50);
        }];
        myHeadView.layer.cornerRadius = 25;
        myHeadView.clipsToBounds = YES;
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:21];
        nameLabel.text = _model.nickname;
        [cell.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(myHeadView.mas_centerY);
            make.leftMargin.mas_equalTo(myHeadView.mas_right).offset(20);
            make.width.mas_lessThanOrEqualTo(200);
            make.height.mas_equalTo(60);
        }];
    }
    
    else{
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:_iconImageArray[indexPath.row - 1]];
        [cell.contentView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = _titleArray[indexPath.row - 1];
        titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [cell.contentView  addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.leftMargin.mas_equalTo(iconImageView.mas_right).offset(20);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(60);
        }];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor blueColor];
    [cell setSelected:YES animated:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:100.0/255 green:150.0/255 blue:255.0/255 alpha:1];
    
    if (indexPath.row == 0) {
        DetailViewController *myMessageVc = [[DetailViewController alloc] init];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:myMessageVc];
        myMessageVc.userID = _model.id;
        myMessageVc.userName = _model.nickname;
        [_menuController setRootController:nv animated:YES];
    }
    if (indexPath.row == 1) {
        if([MainViewController class] == [_menuController.rootViewController class] ){
          [_menuController showRootController:YES];
        }
        else{
            MainViewController *mainvc = [[MainViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:mainvc];
            [_menuController setRootController:nvc animated:YES];
        }
    }
    if (indexPath.row == 2) {
        PlazaViewController *pVc = [[PlazaViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:pVc];
        [_menuController setRootController:nvc animated:YES];
    }
    if (indexPath.row == 3) {
        FriendViewController *fvc = [[FriendViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
        [_menuController setRootController:nvc animated:YES];
    }
    if (indexPath.row == 4) {
        AddFriendViewController *fvc = [[AddFriendViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
        [_menuController setRootController:nvc animated:YES];
    }
    if (indexPath.row == 5) {
        SettingViewController *fvc = [[SettingViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
        [_menuController setRootController:nvc animated:YES];
    }

    

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
