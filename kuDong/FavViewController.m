//
//  FavViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "FavViewController.h"

@interface FavViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_fullFavIdFlagArray;
    NSMutableDictionary *_myFavStatusDict;
}
@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"兴趣爱好";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveDeal)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self createUI];
    [self downLoadData];
}

-(void)createUI{
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
}

-(void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:Favorite parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict1 in dict[@"data"]) {
            FavModel *model = [[FavModel alloc] init];
            [model setValuesForKeysWithDictionary:dict1];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FavModel *model = _dataArray[indexPath.section];
    NSNumber *num = model.types[indexPath.row][@"id"];
    NSLog(@"num = %@",num);
    for (id key in _myFavDict) {
        if ([num isEqualToNumber:key]) {
            [_myFavDict removeObjectForKey:num];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.imageView setImageWithURL:[NSURL URLWithString:model.types[indexPath.row][@"icon_grey"]]];
            return;
        }
    }

   [_myFavDict setObject:model.types[indexPath.row] forKey:num];
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   [cell.imageView setImageWithURL:[NSURL URLWithString:model.types[indexPath.row][@"icon"]]];
}

-(void)saveDeal{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_dataArray.count != 0){
        FavModel *model = _dataArray[section];
        return [NSString stringWithFormat:@"--------------------------%@--------------------------",model.name];
    }
    else return @"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_dataArray.count != 0){
       FavModel *model = _dataArray[section];
        return model.types.count;
    }
    else return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    FavModel *model = _dataArray[indexPath.section];
    
    for (int i = 0; i < _myFavIdArray.count; i++) {
        if ([model.types[indexPath.row][@"id"] isEqualToNumber: _myFavIdArray[i]]) {
            [cell.imageView setImageWithURL:[NSURL URLWithString:model.types[indexPath.row][@"icon"]]];
            break;
        }
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.types[indexPath.row][@"icon_grey"]]];
        cell.textLabel.text = model.types[indexPath.row][@"name"];
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
