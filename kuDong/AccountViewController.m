//
//  AccountViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}


@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    self.title = @"账号绑定";
}

-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return @"                      可以使用绑定的账号登录酷动";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"Share_weibo_h@2x.png"];
       cell.textLabel.text = @"新浪微博";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Share_weixin_h@2x.png"];
        cell.textLabel.text = @"微信";
    }
    
    UISwitch *swit = [[UISwitch alloc] initWithFrame:CGRectMake(10, 0, 60, 20)];
    [swit setOn:YES animated:YES];
    cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [cell.accessoryView addSubview:swit];
    
    
    return cell;
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
