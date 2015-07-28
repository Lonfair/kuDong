//
//  PlazaViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/15.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "PlazaViewController.h"
#import "PlazaCellModel.h"
#import "PlazaTopCell.h"
#import "PlazaSubCell.h"
#import "CommonListViewController.h"
#import "CustomDetailViewController.h"
#import "EventViewController.h"
#import "BrandViewController.h"

@interface PlazaViewController ()
{
    NSMutableArray *_dataArray;
}
@end

@implementation PlazaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"广场";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self downLoadData];
}

-(void)createUI{
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

-(void)addRefreshView{
    
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        [weakSelf downLoadData];
        [weakSelf.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }];
}

-(void)downLoadData
{
    [_dataArray removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:Plaza parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dict1 = dict[@"data"];
        NSMutableArray *topThreeImageArray = [[NSMutableArray alloc] init];
        dict = dict1[@"big"][0];
        [topThreeImageArray addObject:dict];
        dict = dict1[@"small"][0];
        [topThreeImageArray addObject:dict];
        dict = dict1[@"small"][1];
        [topThreeImageArray addObject:dict];
        [_dataArray addObject:topThreeImageArray];
        
        NSMutableArray *mutArr = dict1[@"tags"];
        for(NSDictionary *dataDict  in mutArr)
        {
            PlazaCellModel *model = [[PlazaCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDict];
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

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        if (indexPath.row == 0) {
            static NSString *CellIDTop = @"cellIDTop";
            PlazaTopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDTop];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PlazaTopCell" owner:self options:nil] firstObject];
            }
            
            [cell.bigImage setImageWithURL:[NSURL URLWithString:_dataArray[0][0][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *tapbigImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.bigImage addGestureRecognizer:tapbigImage];
            cell.bigImage.tag = [(_dataArray[0][0][@"link_value"]) integerValue];
            
            [cell.leftSmallImage setImageWithURL:[NSURL URLWithString:_dataArray[0][1][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *tapleftImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.leftSmallImage addGestureRecognizer:tapleftImage];
            cell.leftSmallImage.tag = [(_dataArray[0][1][@"link_value"]) integerValue];
            
            [cell.rightSmallImage setImageWithURL:[NSURL URLWithString:_dataArray[0][2][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *taprightImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.rightSmallImage addGestureRecognizer:taprightImage];
            cell.rightSmallImage.tag = [(_dataArray[0][2][@"link_value"]) integerValue];
            
            cell.bigImageLabel.text = _dataArray[0][0][@"title"];
            cell.leftImageLabel.text = _dataArray[0][1][@"title"];
            cell.rightImageLabel.text = _dataArray[0][2][@"title"];
            
            UITapGestureRecognizer *eventTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventTapDeal:)];
            [cell.activityImageView addGestureRecognizer:eventTap];
            
            UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newTapDeal:)];
            [cell.newsImageView addGestureRecognizer:newTap];
            
            UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapDeal:)];
            [cell.loginImageView addGestureRecognizer:loginTap];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            static NSString *CellIDSub = @"cellIDSub";
            PlazaSubCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDSub];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PlazaSubCell" owner:self options:nil] firstObject];
            }
            PlazaCellModel *model = _dataArray[indexPath.row];
            cell.titleLabel.text = [NSString stringWithFormat:@"#%@",model.name];
            UITapGestureRecognizer *taptitleImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.titleImageView addGestureRecognizer:taptitleImageView];
            cell.titleImageView.tag = [model.id integerValue];
            
            [cell.firstImageView setImageWithURL:[NSURL URLWithString:model.feeds[0][@"pic"][@"url"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            
            UITapGestureRecognizer *tapfirstImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
            [cell.firstImageView addGestureRecognizer:tapfirstImageView];
            cell.firstImageView.tag = [model.feeds[0][@"id"] integerValue];
            
            [cell.secondImageView setImageWithURL:[NSURL URLWithString:model.feeds[1][@"pic"][@"url"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            UITapGestureRecognizer *tapsecondImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
            [cell.secondImageView addGestureRecognizer:tapsecondImageView];
            cell.secondImageView.tag = [model.feeds[1][@"id"] integerValue];
            
            [cell.thirdImageView setImageWithURL:[NSURL URLWithString:model.feeds[2][@"pic"][@"url"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            UITapGestureRecognizer *tapthirdImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailTapDeal:)];
            [cell.thirdImageView addGestureRecognizer:tapthirdImageView];
            cell.thirdImageView.tag = [model.feeds[2][@"id"] integerValue];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
}

-(void)eventTapDeal:(UITapGestureRecognizer *)tap
{
    EventViewController *evc = [[EventViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
}

-(void)newTapDeal:(UITapGestureRecognizer *)tap
{
    CommonListViewController *cvc = [[CommonListViewController alloc] init];
    cvc.newsTopic = @"new";
    [self.navigationController pushViewController:cvc animated:YES];
}

-(void)loginTapDeal:(UITapGestureRecognizer *)tap
{
    BrandViewController *bvc = [[BrandViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(void)detailTapDeal:(UITapGestureRecognizer *)tap
{
    CustomDetailViewController *cvc = [[CustomDetailViewController alloc] init];
    cvc.userID = tap.view.tag;
    [self.navigationController pushViewController:cvc animated:YES];
}

-(void)tapImageDeal:(UITapGestureRecognizer *)tap
{
    CommonListViewController *cnv = [[CommonListViewController alloc] init];
    NSLog(@"%li",tap.view.tag);
    cnv.topicID = tap.view.tag;
    
    [self.navigationController pushViewController:cnv animated:YES];
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
