//
//  CommonListViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "CommonListViewController.h"
#import "PubCellModel.h"
#import "PubTableViewCellNew.h"
#import "PhotoListCell.h"

@interface CommonListViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _segmentValue;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UISegmentedControl *_segmentControl;
}
@end

@implementation CommonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self createUI];
    [self downLoadData];
}

-(void)createUI
{
    _dataArray = [[NSMutableArray alloc] init];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[[UIImage imageNamed:@"tab_profile_feed_grid_h.png"],[UIImage imageNamed:@"tab_profile_feed_list_h.png"]]];
    _segmentControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl addTarget:self action:@selector(segmentSelectChange:) forControlEvents:UIControlEventValueChanged];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 120;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.tableHeaderView = _segmentControl;
    [self.view addSubview:_tableView];
}

-(void)segmentSelectChange:(UISegmentedControl *)segmentControl
{
    _segmentValue = segmentControl.selectedSegmentIndex;
    [_tableView reloadData];
}

-(void)downLoadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if(_newsTopic == nil){
    [manager GET:[NSString stringWithFormat:topicOfGround,_topicID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        dict1 = dict[@"data"];
        NSArray *array = [[NSArray alloc] init];
        array = dict1[@"values"];
        
        for(NSDictionary *modelDict in array){
            PubCellModel *model = [[PubCellModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDict];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    }
    else{
        [manager GET:New parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
            dict1 = dict[@"data"];
            NSArray *array = [[NSArray alloc] init];
            array = dict1[@"values"];
            
            for(NSDictionary *modelDict in array){
                PubCellModel *model = [[PubCellModel alloc] init];
                [model setValuesForKeysWithDictionary:modelDict];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败");
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segmentValue == 1){
        return (_dataArray.count-1);
    }
    else
        return (_dataArray.count)/3 + ((_dataArray.count%3) == 0 ?0:1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmentValue == 0) {
        static NSString *cellID1 = @"cell1";
        PhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoListCell" owner:self options:nil] firstObject];
        }
        
        PubCellModel *model = [[PubCellModel alloc] init];
        if(indexPath.row*3+0 < _dataArray.count){
            model = _dataArray[indexPath.row*3+0];
            
            [cell.firstImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID1 = model.id.integerValue;
        }
        
        if(indexPath.row*3+1 < _dataArray.count){
            model = _dataArray[indexPath.row*3+1];
            
            [cell.secondImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID2 = model.id.integerValue;

        }
        
        if(indexPath.row*3+2 < _dataArray.count){
            model = _dataArray[indexPath.row*3+2];
            
            [cell.thirdImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID3 = model.id.integerValue;
        }
        
        cell.vc = self;
        [cell addTap];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else{
        static NSString *cellID2 = @"cell2";
        PubTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PubTableViewCellNew" owner:self options:nil] firstObject];
        }
        PubCellModel *model = _dataArray[indexPath.row];
        [cell initAllSubViews];
        [cell setContent:model];
        cell.vc = self;
        [cell addTapWithModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
