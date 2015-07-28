//
//  FansOrFollowViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "FansOrFollowViewController.h"
#import "DetailModel.h"
#import "DetailViewController.h"

@interface FansOrFollowViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation FansOrFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    [self downLoadData];
}

-(void)createUI{

     _dataArray = [[NSMutableArray alloc] init];
     _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60) style:UITableViewStyleGrouped];
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];

}

-(void)downLoadData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [[NSString alloc] init];
    
    if(_fansOrFollow == UserFans){
        urlString = [NSString stringWithFormat:fans,_userID];
        self.navigationItem.title = @"粉丝";
    }else if(_fansOrFollow == UserFollow){
         urlString = [NSString stringWithFormat:following,_userID];
        self.navigationItem.title = @"关注的人";
    }
    
    
    [manager.requestSerializer setValue:@"1.1.1"forHTTPHeaderField:@"app_version" ];
    [manager.requestSerializer setValue:@"135150" forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:@"4.3"forHTTPHeaderField:@"os_version" ];
    [manager.requestSerializer setValue:@"A0000049B31052"forHTTPHeaderField:@"openudid" ];
    [manager.requestSerializer setValue:@"Android"forHTTPHeaderField: @"os" ];
    [manager.requestSerializer setValue:@"Keep-Alive"forHTTPHeaderField:@"Connection" ];
    [manager.requestSerializer setValue:@"PHPSESSID=qir0v51ks1sa594kjfgve9gda1;REMEMBERME=QllcQnVuZGxlXFdlYkJ1bmRsZVxFbnRpdHlcVXNlcjpiMkYxZEdoZmQyVmphR0YwWDI4eE5tTjNkV3BqTjJSa2JuZDJiV0Z5WVhCcGFHOW9lVzFoYzIxQWJHVmtiMjVuTG1sdDoxNDY4NDU4Nzc3OjBjZjUwMTdkNTZlMTI1MTJjODEyMmRmY2FhYjc4NTJlZDFjOWFlNTEzZTAzMDIwNDFlMTFhNWYxNWRlODQ5NjE%3D;"forHTTPHeaderField:@"Cookie" ];
    [manager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding" ];
    [manager.requestSerializer setValue:@"huawei"forHTTPHeaderField:@"channel" ];
    [manager.requestSerializer setValue:@"kudong/android"forHTTPHeaderField:@"User-Agent" ];
    [manager.requestSerializer setValue:@"ledong.im"forHTTPHeaderField:@"Host" ];
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict1 in dict[@"data"][@"values"]) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID1 = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        }
        DetailModel *model = _dataArray[indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.avatar_small] placeholderImage:[UIImage imageNamed:@"user_icon.9.png"]];
        cell.imageView.layer.cornerRadius = cell.imageView.bounds.size.width/2;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.userInteractionEnabled = YES;
        cell.textLabel.text = model.nickname;
        cell.detailTextLabel.text = model.desc;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapDeal:)];
        cell.imageView.tag = model.id.integerValue;
        [cell.imageView addGestureRecognizer:headTap];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 70, 25);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryView = button;
        [button setBackgroundImage:[UIImage imageNamed:@"Friend_btn_follow@2x.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Friend_btn_followed@2x.png"] forState:UIControlStateSelected];
        [button setTitle:@"关注" forState:UIControlStateNormal];
        [button setTitle:@"已关注" forState:UIControlStateSelected];
        if ([model.relationship isEqualToString:@"no"]) {
            
            button.selected = NO;
        }
        
        
        return cell;
}

-(void)followClick:(UIButton *)button{
    if (button.selected == NO) {
        button.selected = YES;
    }else
        button.selected = NO;
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
