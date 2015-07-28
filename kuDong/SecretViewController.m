//
//  SecretViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "SecretViewController.h"

@interface SecretViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation SecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐私设置";
    [self createUI];
}

-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"是否公开以下信息?";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        cell.textLabel.text = @"性别";
        UISwitch *swit = [[UISwitch alloc] initWithFrame:CGRectMake(10, 0, 60, 20)];
        [swit setOn:YES animated:YES];
        cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [cell.accessoryView addSubview:swit];
        
    }else {
         cell.textLabel.text = @"年龄";
        UISwitch *swit = [[UISwitch alloc] initWithFrame:CGRectMake(10, 0, 60, 20)];
        [swit setOn:YES animated:YES];
        cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [cell.accessoryView addSubview:swit];
    }
    
    
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
