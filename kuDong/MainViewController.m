//
//  MainViewController.m
//  kuDong
//
//  Created by qianfeng on 15/6/28.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "MainViewController.h"
#import "PubCellModel.h"
#import "PubTableViewCellNew.h"
#import "PlazaCellModel.h"
#import "PlazaTopCell.h"
#import "PlazaSubCell.h"
#import "CommonListViewController.h"
#import "CustomDetailViewController.h"
#import "EventViewController.h"
#import "BrandViewController.h"
#import "DetailViewController.h"

@interface MainViewController () <UIScrollViewDelegate,UISearchBarDelegate,pubCellDelegate>
{
    NSArray *_titleArray;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray3;
    UIPageControl *_page;
    UISearchBar *_searchBar;
    int _offSet1;
    int _flag1;
    int _offSet2;
    int _flag2;
    
}

@property (strong,nonatomic) MPMoviePlayerController *vedioPlayer;
@property (strong,nonatomic) MPMoviePlayerViewController *vedioViewPlayer;

@end

@implementation MainViewController

-(void)viewWillDisappear:(BOOL)animated{
    _page.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    _page.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _vedioViewPlayer = [[MPMoviePlayerViewController alloc] init];
//    _vedioPlayer = [[MPMoviePlayerController alloc] init];
//    [self addChildViewController:_vedioPlayer];
//    _vedioViewPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://live.3gv.ifeng.com/live/zhongwen.m3u8"]];
//    [self.navigationController addChildViewController:_vedioViewPlayer];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"酷动精选";
    
    _page = [[UIPageControl alloc] init];
    _page.center = CGPointMake(self.view.bounds.size.width/2, 36);
    _page.numberOfPages = 3;
    [self.navigationController.navigationBar addSubview:_page];
    _titleArray = @[@"酷动精选",@"我的关注",@"广场"];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    CGRect frame = _scrollView.frame;
    frame.origin.y += 64;
    _scrollView.frame = frame;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
    _scrollView.delegate = (id<UIScrollViewDelegate>)self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];

    _dataArray1 = [[NSMutableArray alloc] init];
    _dataArray2 = [[NSMutableArray alloc] init];
    _dataArray3 = [[NSMutableArray alloc] init];
    
    if (!_tableView1) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [_scrollView addSubview:tableView];
        self.tableView1 = tableView;
        _tableView1.estimatedRowHeight = 200;
        _tableView1.rowHeight = UITableViewAutomaticDimension;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    if (!_tableView2) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [_scrollView addSubview:tableView];
        self.tableView2 = tableView;
        _tableView2.estimatedRowHeight = 200;
        _tableView2.rowHeight = UITableViewAutomaticDimension;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    if (!_tableView3) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [_scrollView addSubview:tableView];
        self.tableView3 = tableView;
        _tableView3.estimatedRowHeight = 120;
        _tableView3.rowHeight = UITableViewAutomaticDimension;
        _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        _tableView3.tableHeaderView = _searchBar;
    }
    [self addRefreshView];
    [self downLoadData1];
    [self downLoadData2];
    [self downLoadData3];
}

-(void)addRefreshView{
    
    __weak typeof (self) weakSelf = self;
    [_tableView1 addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{

        _flag1 = 0;
        _offSet1 = 0;
        [weakSelf downLoadData1];
        [weakSelf.tableView1 headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }];
    

    [_tableView1 addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{

        _flag1 = 1;
        _offSet1 += 30;
        [weakSelf downLoadData1];
        [weakSelf.tableView1 footerEndRefreshing];
        
    }];
    
    [_tableView2 addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        _flag2 = 0;
        _offSet2 = 0;
        [weakSelf downLoadData2];
        [weakSelf.tableView2 headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }];
    
    
    [_tableView2 addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        _flag2 = 1;
        _offSet2 += 30;
        [weakSelf downLoadData2];
        [weakSelf.tableView2 footerEndRefreshing];
        
    }];
    
    [_tableView3 addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        [weakSelf downLoadData3];
        [weakSelf.tableView3 headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.view.bounds.size.width;
    _page.currentPage = page;
    self.navigationItem.title = _titleArray[page];
}

-(void)downLoadData1
{
    if (_flag1 == 0) {
        [_dataArray1 removeAllObjects];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:kuDongJingXuan,_offSet1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        dict1 = dict[@"data"];
        NSArray *array = [[NSArray alloc] init];
        array = dict1[@"values"];
        for(NSDictionary *modelDict in array){
            PubCellModel *model = [[PubCellModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDict];
            [_dataArray1 addObject:model];
        }
        [_tableView1 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)downLoadData2
{
    
    if (_flag2 == 0) {
        [_dataArray2 removeAllObjects];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [manager.requestSerializer setValue:@"1.1.1"forHTTPHeaderField:@"app_version" ];
//    [manager.requestSerializer setValue:@"135150" forHTTPHeaderField:@"uid"];
//    [manager.requestSerializer setValue:@"4.3"forHTTPHeaderField:@"os_version" ];
//    [manager.requestSerializer setValue:@"A0000049B31052"forHTTPHeaderField:@"openudid" ];
//    [manager.requestSerializer setValue:@"Android"forHTTPHeaderField: @"os" ];
//    [manager.requestSerializer setValue:@"Keep-Alive"forHTTPHeaderField:@"Connection" ];
//    [manager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding" ];
//    [manager.requestSerializer setValue:@"huawei"forHTTPHeaderField:@"channel" ];
//    [manager.requestSerializer setValue:@"kudong/android"forHTTPHeaderField:@"User-Agent" ];
//    [manager.requestSerializer setValue:@"ledong.im"forHTTPHeaderField:@"Host" ];
    
    
    [manager GET:[NSString stringWithFormat:GuanZhu,_offSet2] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        dict1 = dict[@"data"];
        NSArray *array = [[NSArray alloc] init];
        array = dict1[@"values"];
        for(NSDictionary *modelDict in array){
            PubCellModel *model = [[PubCellModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDict];
            [_dataArray2 addObject:model];
        }
        [_tableView2 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
}

-(void)downLoadData3
{
    [_dataArray3 removeAllObjects];
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
        [_dataArray3 addObject:topThreeImageArray];
        
        NSMutableArray *mutArr = dict1[@"tags"];
        for(NSDictionary *dataDict  in mutArr)
        {
            PlazaCellModel *model = [[PlazaCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDict];
            [_dataArray3 addObject:model];
        }
        [_tableView3 reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//- (void)viewDidUnload {
//    [super viewDidUnload];
//    self.tableView1 = nil;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return YES;
//}

#pragma mark - UITableViewDataSource

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == _tableView1) {
//        return 100;
//    }
//    if (tableView == _tableView3) {
//        if (indexPath.row == 0) {
//            return 140;
//        }else return 80;
//    }
//    
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView1) {
        return _dataArray1.count;
    }
    else if (tableView == _tableView2){
        return _dataArray2.count;
    }
    else return _dataArray3.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _tableView1){
    
        static NSString *CellID1 = @"Cell1";
        PubTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:CellID1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PubTableViewCellNew" owner:self options:nil] firstObject];
        }
        PubCellModel *model = _dataArray1[indexPath.row];
        [cell initAllSubViews];
        [cell setContent:model];
        cell.vc = self;
        cell.delegate = self;
        [cell addTapWithModel:model];
        
        if(model.video != nil && _vedioViewPlayer == nil){
//        self.vedioPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:model.video[@"url"]]];
//        _vedioViewPlayer.contentURL = [NSURL URLWithString:model.video[@"url"]];
//            _vedioViewPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model.video[@"url"]]];
//            [self addChildViewController:_vedioViewPlayer];
//        self.vedioPlayer.view.frame = cell.photoImageView.bounds;

//        [cell.photoImageView addSubview:self.vedioPlayer.view];
//        [self.vedioPlayer prepareToPlay];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    else if(tableView == _tableView2){
        static NSString *CellID1 = @"Cell1";
        PubTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:CellID1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PubTableViewCellNew" owner:self options:nil] firstObject];
        }
        PubCellModel *model = _dataArray2[indexPath.row];
        [cell initAllSubViews];
        [cell setContent:model];
        cell.vc = self;
        [cell addTapWithModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else {

        if (indexPath.row == 0) {
            static NSString *CellIDTop = @"cellIDTop";
            PlazaTopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDTop];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PlazaTopCell" owner:self options:nil] firstObject];
            }
            
            [cell.bigImage setImageWithURL:[NSURL URLWithString:_dataArray3[0][0][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *tapbigImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.bigImage addGestureRecognizer:tapbigImage];
            cell.bigImage.tag = [(_dataArray3[0][0][@"link_value"]) integerValue];
            
            [cell.leftSmallImage setImageWithURL:[NSURL URLWithString:_dataArray3[0][1][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *tapleftImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.leftSmallImage addGestureRecognizer:tapleftImage];
            cell.leftSmallImage.tag = [(_dataArray3[0][1][@"link_value"]) integerValue];
            
            [cell.rightSmallImage setImageWithURL:[NSURL URLWithString:_dataArray3[0][2][@"pic"]] placeholderImage:
             [UIImage imageNamed:@"chatBar_more_photo@2x.png"]];
            UITapGestureRecognizer *taprightImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageDeal:)];
            [cell.rightSmallImage addGestureRecognizer:taprightImage];
            cell.rightSmallImage.tag = [(_dataArray3[0][2][@"link_value"]) integerValue];
            
            cell.bigImageLabel.text = _dataArray3[0][0][@"title"];
            cell.leftImageLabel.text = _dataArray3[0][1][@"title"];
            cell.rightImageLabel.text = _dataArray3[0][2][@"title"];
            
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
            PlazaCellModel *model = _dataArray3[indexPath.row];
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
   
}

-(void)vedioTapDeal:(UITapGestureRecognizer *)tap{
//    NSString *urlString = @"http://live.3gv.ifeng.com/live/zhongwen.m3u8";
//    MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
//    [self addChildViewController:mpvc];
//    
//    mpvc.view.frame = CGRectZero;
//    
//    [self.view addSubview:mpvc.view];
//    [_vedioPlayer play];
//    [self presentViewController:_vedioViewPlayer animated:YES completion:nil];
//    [self presentMoviePlayerViewControllerAnimated:_vedioViewPlayer];
   
}

-(void)detailTapDeal:(UITapGestureRecognizer *)tap
{
    CustomDetailViewController *cvc = [[CustomDetailViewController alloc] init];
    cvc.userID = tap.view.tag;
    [self.navigationController pushViewController:cvc animated:YES];
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
