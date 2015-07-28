//
//  AddFriendViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "AddFriendViewController.h"
#import "DetailModel.h"
#import "ZJSliderView.h"
#import "DetailViewController.h"

#define SliderViewControlHeight 44

@interface AddFriendViewController ()  <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView1;
    UITableView *_tableView2;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    UIViewController *_vc1;
    UIViewController *_vc2;
}

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"添加好友界面";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    [self downLoadData];
}

-(void)createUI{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    ZJSliderView *sliderView = [[ZJSliderView alloc] init];
    
    sliderView.frame = self.view.frame;
    
    NSMutableArray *marr = [[NSMutableArray alloc] init];
    NSArray *titleArray = @[@"酷动达人",@"最新加入"];
    for(int i=0; i<titleArray.count; i++)
    {
        if (i == 0) {
            _vc1 = [[UIViewController alloc] init];
            _vc1.title = titleArray[i];
            [marr addObject:_vc1];
        }else{
            _vc2 = [[UIViewController alloc] init];
            _vc2.title = titleArray[i];
            [marr addObject:_vc2];
        }
        
    }
    
    [sliderView setViewControllers:marr owner:self];
    [self.view addSubview:sliderView];
    
    UIView *topControlView = [sliderView topControlViewWithFrame:CGRectMake(0, 60, size.width, 44) titleLabelWidth:size.width/2];
    
    [self.view addSubview:topControlView];
    
    
    _dataArray1 = [[NSMutableArray alloc] init];
    _dataArray2 = [[NSMutableArray alloc] init];
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStyleGrouped];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.rowHeight = 60;
    [_vc1.view addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStyleGrouped];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.rowHeight = 60;
    [_vc2.view addSubview:_tableView2];

}

-(void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:AddFriendHot parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict1 in dict[@"data"][@"values"]) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_dataArray1 addObject:model];
        }
        [_tableView1 reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    
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
    
    
    [manager GET:AddFriendNew parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict1 in dict[@"data"][@"values"]) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_dataArray2 addObject:model];
        }
        [_tableView2 reloadData];
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
    if(tableView == _tableView1){
    return _dataArray1.count;
    }else
        return _dataArray2.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"cell1";
    static NSString *cellID2 = @"cell2";
    if (tableView == _tableView1) {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
    }
     DetailModel *model = _dataArray1[indexPath.row];
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
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID2];
        }
        DetailModel *model = _dataArray2[indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.avatar_small] placeholderImage:[UIImage imageNamed:@"user_icon.9.png"]];
        cell.imageView.layer.cornerRadius = 20;
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
