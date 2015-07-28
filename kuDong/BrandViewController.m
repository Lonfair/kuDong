//
//  BrandViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandCellModel.h"
#import "BrandTableViewCell.h"

@interface BrandViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self downLoadData];
    
}

-(void)createUI{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    _tableView.backgroundColor = [UIColor darkGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    [self.view addSubview:_tableView];
}

-(void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:Brand parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for(NSDictionary *dictModel in dict[@"data"][@"values"]){
            BrandCellModel *model = [[BrandCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dictModel];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:self options:nil] firstObject];
    }
    
    BrandCellModel *model = _dataArray[indexPath.row];
    [cell initAllSubViews];
    [cell setContent:model];
    
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
