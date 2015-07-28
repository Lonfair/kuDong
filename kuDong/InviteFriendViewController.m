//
//  InviteFriendViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "InviteFriendViewController.h"

@interface InviteFriendViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}


@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    self.title = @"邀请好友";
}

-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"Friend_qq@2x.png"];
        cell.textLabel.text = @"邀请QQ好友";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Share_weixin_h@2x.png"];
        cell.textLabel.text = @"邀请微信好友";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
