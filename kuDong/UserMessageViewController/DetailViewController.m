//
//  DetailViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "PubTableViewCellNew.h"
#import "PhotoListCell.h"
#import "PubCellModel.h"
#import "HeaderView.h"
#import "FansOrFollowViewController.h"

#define HeaderViewHeight self.view.bounds.size.height/2-10
#define Ritio self.view.frame.size.width/320

@interface DetailViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_customMesArray;
    NSUInteger _segementFlag;
    HeaderView *_headerView;
    UIPageControl *_page;
    DetailModel *_mainMessageModel;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _segementFlag = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createHeaderView];
    [self createTableView];
    [self downLoadData];
}

-(void)createHeaderView
{
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height*0.4)];
    _headerView.userInteractionEnabled = YES;
    
    _headerView.segmentControl.selectedSegmentIndex = 0;
    [_headerView.segmentControl addTarget:self action:@selector(segementSelect:) forControlEvents:UIControlEventValueChanged];
}

-(void)segementSelect:(UISegmentedControl *)segement
{
    _segementFlag = segement.selectedSegmentIndex;
    [_tableView reloadData];
}

-(void)createTableView
{
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.tableHeaderView = _headerView;

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}

-(void)downLoadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"1.1.1"forHTTPHeaderField:@"app_version" ];
    [manager.requestSerializer setValue:@"135150" forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:@"4.3"forHTTPHeaderField:@"os_version" ];
    [manager.requestSerializer setValue:@"A0000049B31052"forHTTPHeaderField:@"openudid" ];
    [manager.requestSerializer setValue:@"Android"forHTTPHeaderField: @"os" ];
    [manager.requestSerializer setValue:@"Keep-Alive"forHTTPHeaderField:@"Connection" ];
    [manager.requestSerializer setValue:@"PHPSESSID=qir0v51ks1sa594kjfgve9gda1;REMEMBERME=QllcQnVuZGxlXFdlYkJ1bmRsZVxFbnRpdHlcVXNlcjpiMkYxZEdoZmQyVmphR0YwWDI4eE5tTjNkV3BqTjJSa2JuZDJiV0Z5WVhCcGFHOW9lVzFoYzIxQWJHVmtiMjVuTG1sdDoxNDY4NDU4Nzc3OjBjZjUwMTdkNTZlMTI1MTJjODEyMmRmY2FhYjc4NTJlZDFjOWFlNTEzZTAzMDIwNDFlMTFhNWYxNWRlODQ5NjE%3D;"forHTTPHeaderField:@"Cookie" ];
    [manager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding" ];
    [manager.requestSerializer setValue:@"huawei"forHTTPHeaderField:@"channel" ];
    [manager.requestSerializer setValue:@"kudong/android"forHTTPHeaderField:@"User-Agent" ];
    [manager.requestSerializer setValue:@"ledong.im"forHTTPHeaderField:@"Host" ];
    
    [manager GET:[NSString stringWithFormat:basicMessage,_userID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dict1 = dict[@"data"];
        _mainMessageModel = [[DetailModel alloc] init];
        [_mainMessageModel setValuesForKeysWithDictionary:dict1];
        NSLog(@"关系 = %@",_mainMessageModel.relationship);
        [self setHeaderViewWithModel:_mainMessageModel];
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    [manager GET:[NSString stringWithFormat:mainPage,_userID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        NSLog(@"_dataArray.count = %li",_dataArray.count);
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败23");
        NSLog(@"sdf = %@",_userID);
    }];
}

-(void)setHeaderViewWithModel:(DetailModel *)model{
    
    [_headerView.headImageView setImageWithURL:[NSURL URLWithString:model.avatar_small] placeholderImage:[UIImage imageNamed:@"portrait_80.png"]];
    _headerView.placeLabel.text = model.area[@"fullname"];
    _headerView.photoLabelTitle.text = model.feed_count.stringValue;
    _headerView.fansLabelTitle.text = model.fans_count.stringValue;
    _headerView.focusLabelTitle.text = model.follow_count.stringValue;
    if ([model.relationship isEqualToString:@"no"]) {
        _headerView.myFocusLabelStatus.text = @"关注";
        _headerView.myFocusImageView.backgroundColor = [UIColor cyanColor];
        _headerView.myFocusImageView.alpha = 0.6;
    }
    if ([model.relationship isEqualToString:@"following"]) {
        _headerView.myFocusLabelStatus.text = @"已关注";
        _headerView.myFocusImageView.backgroundColor = [UIColor lightGrayColor];
        _headerView.myFocusImageView.alpha = 1;
    }
    if ([model.relationship isEqualToString:@"me"]) {
        _headerView.myFocusLabelStatus.text = @"编辑个人资料";
        _headerView.myFocusImageView.backgroundColor = [UIColor lightGrayColor];
        _headerView.myFocusImageView.alpha = 1;
    }
    
    _headerView.fansImageView.userInteractionEnabled = YES;
    _headerView.focusImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *fansTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fansOrfollowTap:)];
    [_headerView.fansImageView addGestureRecognizer:fansTap];
    _headerView.fansImageView.tag = UserFans;
    
    UITapGestureRecognizer *followTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fansOrfollowTap:)];
    [_headerView.focusImageView addGestureRecognizer:followTap];
    _headerView.focusImageView.tag = UserFollow;
}

-(void)fansOrfollowTap:(UITapGestureRecognizer *)tap{
    FansOrFollowViewController *vc = [[FansOrFollowViewController alloc] init];
    vc.userID = self.userID;
    vc.fansOrFollow = tap.view.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_segementFlag == 0) {
        if (indexPath.row == 0) {
            return HeaderViewHeight-180;
        }else return 50;
    }
    else if (_segementFlag == 2){
        return (self.view.frame.size.width-20)/3 + 10;
    }
    else {
        PubCellModel *model = _dataArray[indexPath.row];
        CGFloat height = model.pic_height.integerValue/model.pic_width.integerValue * self.view.bounds.size.width;
        height += 54;
        height += (model.content.length/21 +1)*26;
        height += 42;
        height += (self.view.bounds.size.width - 101)/8;
        if (model.tags.count > 0) {
            height += 26;
        }
        height += 15;
        height += 26;
        height += 26 * model.comments.count;
        return height;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segementFlag == 0) {
        return 5;
    }
    if (_segementFlag == 1){
        return (NSInteger)(_dataArray.count);
    }
    else
        return (NSInteger)(_dataArray.count)/3 + ((_dataArray.count%3) == 0 ?0:1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    static NSString *cellID2 = @"cell2";
    static NSString *cellID3 = @"cell3";
    
    if (_segementFlag == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        }
        for(UIView *view1 in cell.contentView.subviews){
            [view1 removeFromSuperview];
        }
        DetailModel *model = _mainMessageModel;
        if (indexPath.row == 0) {
            
            long favPageNum = model.fav.count/4 + (model.fav.count%4 == 0?0:1);
            UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:cell.contentView.frame];
            scrollerView.delegate = self;
            scrollerView.pagingEnabled = YES;
            scrollerView.bounces = NO;
            scrollerView.showsHorizontalScrollIndicator = NO;
            scrollerView.showsVerticalScrollIndicator = NO;
            scrollerView.contentSize = CGSizeMake(cell.contentView.frame.size.width *favPageNum, cell.contentView.frame.size.height);
            [cell.contentView addSubview:scrollerView];
                
                _page = [[UIPageControl alloc] init];
                _page.center = CGPointMake(cell.contentView.frame.size.width/2, cell.contentView.frame.size.height-10);
                _page.numberOfPages = favPageNum;
                _page.currentPageIndicatorTintColor = [UIColor orangeColor];
                _page.pageIndicatorTintColor = [UIColor grayColor];
                [cell.contentView addSubview:_page];
            
            for (int i = 0 ; i < model.fav.count; i++) {
                UIImageView *favImageView = [[UIImageView alloc] init];
                UILabel *favnamelabel = [[UILabel alloc] init];
                [scrollerView addSubview:favImageView];
                [scrollerView addSubview:favnamelabel];
                
                favImageView.backgroundColor = [UIColor lightGrayColor];
                favImageView.layer.cornerRadius = 30;
                [favImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(30+90*i);
                    make.top.mas_equalTo(20);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
                
                [favnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(favImageView.mas_centerX);
                    make.top.mas_equalTo(favImageView.mas_bottom).offset(5);
                }];
                
                [favImageView setImageWithURL:[NSURL URLWithString:model.fav[i][@"icon"]]];
                favnamelabel.text = model.fav[i][@"name"];
                
            }
        }
        else if(indexPath.row == 1){
            UILabel *text = [[UILabel alloc] init];
            text.backgroundColor = [UIColor clearColor];
            text.font = [UIFont boldSystemFontOfSize:20];
            text.text = @"基本信息";
            [cell.contentView addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(100, 0.4*cell.contentView.bounds.size.height));
            }];
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        else if (indexPath.row == 2){
            UILabel *sex = [[UILabel alloc] init];
            sex.backgroundColor = [UIColor clearColor];
            sex.font = [UIFont systemFontOfSize:20];
            sex.text = @"性别";
            [cell.contentView addSubview:sex];
            [sex mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(50, 0.4*cell.contentView.bounds.size.height));
            }];
            
            UILabel *sexText = [[UILabel alloc] init];
            sexText.backgroundColor = [UIColor clearColor];
            sexText.font = [UIFont boldSystemFontOfSize:20];
            if ([model.data[@"sex"] isEqualToNumber:@(0)]) {
                sexText.text = @"女";
            }else
                sexText.text = @"男";
            
            [cell.contentView addSubview:sexText];
            [sexText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(sex.mas_right).offset(15);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(30, 0.4*cell.contentView.bounds.size.height));
            }];
            
            UILabel *age = [[UILabel alloc] init];
            age.backgroundColor = [UIColor clearColor];
            age.font = [UIFont systemFontOfSize:20];
            age.text = @"年龄";
            [cell.contentView addSubview:age];
            [age mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(sexText.mas_right).offset(140);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(50, 0.4*cell.contentView.bounds.size.height));
            }];
            
            UILabel *ageText = [[UILabel alloc] init];
            ageText.backgroundColor = [UIColor clearColor];
            ageText.font = [UIFont boldSystemFontOfSize:20];
            ageText.text = model.data[@"age"];

            [cell.contentView addSubview:ageText];
            [ageText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(age.mas_right).offset(15);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(60, 0.4*cell.contentView.bounds.size.height));
            }];
            
            cell.backgroundColor = [UIColor whiteColor];
        }
        else if (indexPath.row == 3){
            UILabel *text = [[UILabel alloc] init];
            text.backgroundColor = [UIColor clearColor];
            text.font = [UIFont boldSystemFontOfSize:20];
            text.text = @"个人签名";
            [cell.contentView addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(100, 0.4*cell.contentView.bounds.size.height));
            }];
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        else if (indexPath.row == 4){
            UILabel *text = [[UILabel alloc] init];
            text.backgroundColor = [UIColor clearColor];
            text.font = [UIFont boldSystemFontOfSize:20];
            text.text = model.sign;
            [cell.contentView addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(300, 0.4*cell.contentView.bounds.size.height));
            }];
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if (_segementFlag == 1){
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
    
    
    else {
        PhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoListCell" owner:self options:nil] firstObject];
        }
        PubCellModel *model = [[PubCellModel alloc] init];
        if(indexPath.row*3+1 <= _dataArray.count){
        model = _dataArray[indexPath.row*3];
    
        [cell.firstImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID1 = model.id.integerValue;
        }
        
        if(indexPath.row*3+2 <= _dataArray.count){
        model = _dataArray[indexPath.row*3+1];
        
        [cell.secondImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID2 = model.id.integerValue;
        }
        
        if(indexPath.row*3+3 <= _dataArray.count){
        model = _dataArray[indexPath.row*3+2];
        
        [cell.thirdImage setImageWithURL:[NSURL URLWithString:model.pic[@"url_small"]] placeholderImage:[UIImage imageNamed:@"discover_graphic.png"]];
            cell.userID3 = model.id.integerValue;
        }
        
        cell.vc = self;
        [cell addTap];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _page.currentPage = scrollView.contentOffset.x/self.view.bounds.size.width;
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
