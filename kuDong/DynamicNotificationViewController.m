//
//  DynamicNotificationViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "DynamicNotificationViewController.h"

@interface DynamicNotificationViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_headerTitleArr;
    NSArray *_rowContentArr;
}


@end

@implementation DynamicNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    self.title = @"动态提醒设置";
}

-(void)createUI{
    _headerTitleArr = @[@"评论过的作品被回复\nXXX回复了你评论过的作品",@"赞过的作品被回复\n你赞过的作品被回复",@"新作品发布\nXXX发布了新作品",@"好友的新关注\nXXX关注XX"];
    _rowContentArr = @[@[@"任何人",@"好友(互为关注)",@"关闭"],@[@"任何人",@"好友(互为关注)",@"关闭"],@[@"任何人",@"好友(互为关注)",@"关闭"],@[@"开启",@"关闭"]];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return _headerTitleArr[section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _headerTitleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _rowContentArr[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _rowContentArr[indexPath.section][indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
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
