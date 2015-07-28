//
//  CustomDetailViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "CustomDetailViewController.h"
#import "PubTableViewCellNew.h"
#import "CommentCell.h"

@interface CustomDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    PubCellModel *_model;
}

@end

@implementation CustomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片详情";
    _dataArray = [[NSMutableArray alloc] initWithObjects:_model, nil];
    [self createUI];
    [self downloadData];
}

-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _tableView.estimatedRowHeight = 120;
    _tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)downloadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:comment,_userID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = dict[@"data"][@"values"];
        for(NSDictionary *contentDict in arr){
            CommentModel *model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:contentDict];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载数据失败");
    }];
    
    
    [manager GET:[NSString stringWithFormat:UserFeed,_userID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *contentDict = dict[@"data"];
        _model = [[PubCellModel alloc] init];
        [_model setValuesForKeysWithDictionary:contentDict];

        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载数据失败");
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    static NSString *cellID2 = @"cell2";
    if (indexPath.row == 0) {
        PubTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PubTableViewCellNew" owner:self options:nil] firstObject];;
        }
        
        [cell initAllSubViews];
        cell.commentImageView.userInteractionEnabled = NO;
        cell.bottomCommentView.userInteractionEnabled = NO;
        [cell setContent:_model];
        cell.vc = self;
        [cell addTapWithModel:_model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] firstObject];
            
        }
        CommentModel *model = _dataArray[indexPath.row-1];

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
