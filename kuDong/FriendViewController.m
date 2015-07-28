//
//  FriendViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendModel.h"
#import "DetailViewController.h"
#import "DetailModel.h"

@interface FriendViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    DetailModel *_userMessageModel;
}
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友动态";
    self.view.backgroundColor = [UIColor orangeColor];
    [self createUI];
    [self downLoadData];
}

-(void)createUI{
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"userMessageConfig"];
    _userMessageModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *userId = ((NSNumber *)_userMessageModel.id).stringValue;
    NSLog(@"userId = %@",userId);
    [manager.requestSerializer setValue:@"1.1.1"forHTTPHeaderField:@"app_version" ];
    [manager.requestSerializer setValue:@"135150" forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:@"4.3"forHTTPHeaderField:@"os_version" ];
    [manager.requestSerializer setValue:@"A0000049B31052"forHTTPHeaderField:@"openudid" ];
    [manager.requestSerializer setValue:@"Android"forHTTPHeaderField: @"os" ];
    [manager.requestSerializer setValue:@"Keep-Alive"forHTTPHeaderField:@"Connection" ];
    [manager.requestSerializer setValue:@"PHPSESSID=qir0v51ks1sa594kjfgve9gda1;REMEMBERME=QllcQnVuZGxlXFdlYkJ1bmRsZVxFbnRpdHlcVXNlcjpiMkYxZEdoZmQyVmphR0YwWDI4eE5tTjNkV3BqTjJSa2JuZDJiV0Z5WVhCcGFHOW9wlVzFoYzIxQWJHVmtiMjVuTG1sdDoxNDY4NDU4Nzc3OjBjZjUwMTdkNTZlMTI1MTJjODEyMmRmY2FhYjc4NTJlZDFjOWFlNTEzZTAzMDIwNDFlMTFhNWYxNWRlODQ5NjE%3D;"forHTTPHeaderField:@"Cookie" ];
    [manager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding" ];
    [manager.requestSerializer setValue:@"huawei"forHTTPHeaderField:@"channel" ];
    [manager.requestSerializer setValue:@"kudong/android"forHTTPHeaderField:@"User-Agent" ];
    [manager.requestSerializer setValue:@"ledong.im"forHTTPHeaderField:@"Host" ];
    
    [manager GET:MyFriend parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict1 in dict[@"data"][@"values"]) {
            FriendModel *model = [[FriendModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        NSLog(@"下载成功123");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败123");
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"cell1";
//    static NSString *cellID2 = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
    }
    FriendModel *model = _dataArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.byuser[@"avatar_small"]] placeholderImage:[UIImage imageNamed:@"portrait_80.png"]];
    cell.imageView.layer.cornerRadius = 21;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.userInteractionEnabled = YES;
    cell.textLabel.text = model.byuser[@"nickname"];
    cell.textLabel.userInteractionEnabled = YES;
    cell.textLabel.textColor = [UIColor cyanColor];
    cell.detailTextLabel.text = @"关注了你";
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:timeLabel];
    timeLabel.textColor = [UIColor lightGrayColor];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
    }];
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:model.created_at];
    int timeInter = -(int)[createDate timeIntervalSinceNow];
    int second = timeInter;
    int minute = timeInter/60;
    int hour = timeInter/3600;
    int day = timeInter/86400;
    int month = timeInter/(86400*30);
    if (month >= 1) {
        timeLabel.text = [NSString stringWithFormat:@"%d月前",month];
    }
    else if (day >= 1) {
        timeLabel.text = [NSString stringWithFormat:@"%d天前",day];
    }
    else if (hour >= 1) {
        timeLabel.text = [NSString stringWithFormat:@"%d小时前",hour];
    }
    else if (minute >= 1) {
        timeLabel.text = [NSString stringWithFormat:@"%d分钟前",minute];
    }
    else if (second >= 1) {
        timeLabel.text = [NSString stringWithFormat:@"%d秒前",second];
    }
    else{
        timeLabel.text = @"刚刚";
    }
    
    
    UITapGestureRecognizer *userTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    [cell.imageView addGestureRecognizer:userTap1];
    cell.imageView.tag = ((NSNumber *)model.byuser[@"id"]).integerValue;
    
    UITapGestureRecognizer *userTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
    [cell.textLabel addGestureRecognizer:userTap2];
    cell.textLabel.tag = ((NSNumber *)model.byuser[@"id"]).integerValue;
    
    return cell;
}

-(void)userTapDeal:(UITapGestureRecognizer *)tap
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    NSInteger tag1 = tap.view.tag;
    vc.userID = [NSString stringWithFormat:@"%li",tag1];
    [self.navigationController pushViewController:vc animated:YES];
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
