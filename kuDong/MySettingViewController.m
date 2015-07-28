//
//  MySettingViewController.m
//  kuDong
//
//  Created by qianfeng on 15/7/13.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "MySettingViewController.h"
#import "areaCodeModel.h"
#import "FavViewController.h"

@interface MySettingViewController () <UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    NSMutableArray *_contentArray;
    UIImageView *_headerView;
    UIImageView *_headImageView;
    UIViewController *_nickNameViewController;
    UIPickerView *_placePick;
    NSMutableArray *_areaCodeArr;
    NSInteger _cityCount;
    areaCodeModel *_modelArea;
    UIImageView *_pickBackView;
    UIToolbar *_toolBar;
    UIActionSheet *_sexSheet;
    NSInteger _pickViewIndex;
    NSMutableArray *_myFavIdArray;
    NSMutableDictionary *_myFavDict;
    NSMutableDictionary *_PostDict;
    NSString *_nickNamePost;
    NSString *_signPost;
}

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑资料";
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserDefault)];
    self.navigationItem.rightBarButtonItem = barItem;
    [self createUI];
    [self downLoadMyData];
}

-(void)createUI{
    _areaCodeArr = [[NSMutableArray alloc] init];
    _model = [[DetailModel alloc] init];
    _myFavIdArray = [[NSMutableArray alloc] init];
    _myFavDict = [[NSMutableDictionary alloc] init];
    
    _titleArray = @[@"用户名",@"常住地",@"性别",@"出生年月",@"个人签名",@"兴趣爱好"];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    _headerView = [[UIImageView alloc] init];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableView.tableHeaderView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_tableView.tableHeaderView.mas_centerY);
        make.centerX.mas_equalTo(_tableView.tableHeaderView.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _headImageView.image = [UIImage imageNamed:@"emoji_1f60e.png"];
    _headImageView.layer.cornerRadius = 40;
    _headImageView.clipsToBounds = YES;
    [_headerView addSubview:_headImageView];
    
    UIImageView *photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_upload.png"]];
    photoView.frame = CGRectMake(54, 54, 26, 26);
    [_headerView addSubview:photoView];
}

-(void)downLoadMyData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"userMessageConfig"];
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_headImageView setImageWithURL:[NSURL URLWithString:_model.avatar_small] placeholderImage:[UIImage imageNamed:@"user_icon.9.png"]];
    NSString *sex = ([_model.data[@"sex"] isEqualToNumber: @(1)])?@"男":@"女";
    NSString *sexPost = ((NSNumber *)_model.data[@"sex"]).stringValue;
    _contentArray = [[NSMutableArray alloc] initWithObjects:_model.nickname,_model.area[@"fullname"],sex,_model.data[@"birthday"],_model.sign,_model.fav,nil];
    _PostDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"nickname":_model.nickname,@"area_id":_model.area[@"id"],@"sex":sexPost,@"birthday":_model.data[@"birthday"],@"sign":_model.sign,@"fav":_model.fav,@"page":@"edit"}];
    
    for (NSDictionary *dict in _model.fav) {
        NSNumber *num = dict[@"id"];
        NSLog(@"numOri = %@",num.stringValue);
        [_myFavIdArray addObject:num];
        [_myFavDict setObject:dict forKey:num];
    }
    
    NSLog(@"_myFavDict = %@",_myFavDict);
    [_tableView reloadData];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:areaCode parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        for (NSDictionary *cityDict in dict[@"data"]) {
            areaCodeModel *model = [[areaCodeModel alloc] init];
            [model setValuesForKeysWithDictionary:cityDict];
            [_areaCodeArr addObject:model];
        }
        [_placePick reloadAllComponents];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        if(_model.fav.count >= 4)
           return 240;
        else
           return 140;
    }else return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (indexPath.row != 5) {
        cell.textLabel.text = _titleArray[indexPath.row];
        NSString *str = _contentArray[indexPath.row];
        cell.detailTextLabel.text = str;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 5) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"兴趣爱好";
        label.font = [UIFont systemFontOfSize:17];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(40);
        }];
        for (int i = 0; i < _model.fav.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.backgroundColor = [UIColor lightGrayColor];
            imageView.layer.cornerRadius = 25;
            imageView.clipsToBounds = YES;
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:label];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(50);
                make.left.mas_equalTo(15 + (i%4)*80);
                make.top.mas_equalTo(i/4*90 + 60);
            }];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(30);
                make.centerX.mas_equalTo(imageView.mas_centerX);
                make.top.mas_equalTo(imageView.mas_bottom).offset(5);
            }];
            
            [imageView setImageWithURL:[NSURL URLWithString:_contentArray[5][i][@"icon"]]];
            label.text = _contentArray[5][i][@"name"];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        _nickNameViewController = [[UIViewController alloc] init];
        _nickNameViewController.title = @"更改昵称";

        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveNickName)];
        _nickNameViewController.navigationItem.rightBarButtonItem = barItem;
        UITextView *textView =[[UITextView alloc] initWithFrame:_nickNameViewController.view.bounds];
        textView.tag = 100;
        textView.text = _contentArray[0];
        [_nickNameViewController.view addSubview:textView];
        
        [self.navigationController pushViewController:_nickNameViewController animated:YES];
    }
    else if (indexPath.row == 1){

        if (_placePick == nil) {
            _placePick = [[UIPickerView alloc] init];
        }
        if (_pickBackView == nil) {
            _pickBackView = [[UIImageView alloc] init];
        }
        if (_toolBar == nil) {
            _toolBar =  [[UIToolbar alloc] init];
        }
        _pickViewIndex = 0;
        _pickBackView.frame = CGRectMake(0,self.view.bounds.size.height,self.view.bounds.size.width, 244);
        _pickBackView.userInteractionEnabled = YES;
        _pickBackView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_pickBackView];
//        _placePick.frame = CGRectMake(0,40,self.view.bounds.size.width, 220);
        [_pickBackView addSubview:_placePick];
        _placePick.delegate = self;
        _placePick.dataSource = self;
        _placePick.backgroundColor = [UIColor lightGrayColor];
        
        UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickViewYES)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickViewNO)];
        _toolBar.items = @[barItem2,spaceItem,barItem1];
        _toolBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _toolBar.barStyle = UIBarStyleBlackOpaque;
        [_pickBackView addSubview:_toolBar];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = _pickBackView.frame;
            rect.origin.y -= 244;
            _pickBackView.frame = rect;
        }];
        _tableView.userInteractionEnabled = NO;
    }
    else if (indexPath.row == 2){
        if(_sexSheet == nil){
        _sexSheet = [[UIActionSheet alloc] initWithTitle:@"设置性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"女",@"男",nil];
        }
        [_sexSheet showInView:self.view];
    }
    
    else if (indexPath.row == 3){
        if (_placePick == nil) {
            _placePick = [[UIPickerView alloc] init];
        }
        if (_pickBackView == nil) {
            _pickBackView = [[UIImageView alloc] init];
        }
        if (_toolBar == nil) {
            _toolBar =  [[UIToolbar alloc] init];
        }
        _pickViewIndex = 1;
        _pickBackView.frame = CGRectMake(0,self.view.bounds.size.height,self.view.bounds.size.width, 244);
        _pickBackView.userInteractionEnabled = YES;
        _pickBackView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_pickBackView];
//        _placePick.frame = CGRectMake(0,40,self.view.bounds.size.width, 220);
        [_pickBackView addSubview:_placePick];
        _placePick.delegate = self;
        _placePick.dataSource = self;
        _placePick.backgroundColor = [UIColor lightGrayColor];
        
        UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickViewYES)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickViewNO)];
        _toolBar.items = @[barItem2,spaceItem,barItem1];
        _toolBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _toolBar.barStyle = UIBarStyleBlackOpaque;
        [_pickBackView addSubview:_toolBar];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = _pickBackView.frame;
            rect.origin.y -= 244;
            _pickBackView.frame = rect;
        }];
        _tableView.userInteractionEnabled = NO;
    }
    
    else if (indexPath.row == 4){
        _nickNameViewController = [[UIViewController alloc] init];
        _nickNameViewController.title = @"更改签名";
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveSign)];
        _nickNameViewController.navigationItem.rightBarButtonItem = barItem;
        UITextView *textView =[[UITextView alloc] initWithFrame:_nickNameViewController.view.bounds];
        textView.tag = 100;
        textView.text = _contentArray[4];
        [_nickNameViewController.view addSubview:textView];
        
        [self.navigationController pushViewController:_nickNameViewController animated:YES];
    }
    else {
        FavViewController *fvc = [[FavViewController alloc] init];
        fvc.myFavIdArray = _myFavIdArray;
        fvc.myFavDict = _myFavDict;
        [fvc setChangeFav:^(NSMutableArray *arr) {
            _model.fav = arr;
            [_tableView reloadData];
        }];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    _tableView.userInteractionEnabled = YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.detailTextLabel.text = [actionSheet buttonTitleAtIndex:buttonIndex];
    
}

-(void)pickViewYES{
    if (_pickViewIndex == 0) {
        NSInteger city = [_placePick selectedRowInComponent:0];
        NSInteger place = [_placePick selectedRowInComponent:1];
        areaCodeModel *model = _areaCodeArr[city];
       NSString *placeContent = [NSString stringWithFormat:@"%@ %@",model.name,model.cities[place][@"name"]];
        [_contentArray replaceObjectAtIndex:1 withObject:placeContent];
        [_PostDict setValue:model.id forKey:@"area_id"];
        [_tableView reloadData];
    }else if(_pickViewIndex == 1){
        NSInteger year = [_placePick selectedRowInComponent:0] + 1980;
        NSInteger month = [_placePick selectedRowInComponent:1]+1;
        NSInteger day = [_placePick selectedRowInComponent:2]+1;
        NSString *birth = [NSString stringWithFormat:@"%li-%li-%li",year,month,day];
        [_contentArray replaceObjectAtIndex:3 withObject:birth];
        [_PostDict setValue:birth forKey:@"birthday"];
        [_tableView reloadData];
    }
    
    [_placePick removeFromSuperview];
    [_pickBackView removeFromSuperview];
    [_toolBar removeFromSuperview];
    _tableView.userInteractionEnabled = YES;
    
}

-(void)pickViewNO{
    [_placePick removeFromSuperview];
    [_pickBackView removeFromSuperview];
    [_toolBar removeFromSuperview];
    _tableView.userInteractionEnabled = YES;
}

- (NSString *)encodeToPercentEscapeString: (NSString *)input
{

    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8));
    return outputStr;
}

-(void)saveSign{
    UITextView *textView = (UITextView *)[_nickNameViewController.view viewWithTag:100];
      [_contentArray replaceObjectAtIndex:4 withObject:textView.text];
    
    NSString *postSign = [self encodeToPercentEscapeString:textView.text];
    NSLog(@"postSign = %@",postSign);
    [_PostDict setValue:postSign forKey:@"sign"];
    
    [_nickNameViewController.navigationController popViewControllerAnimated:YES];
    [_tableView reloadData];
}

-(void)saveNickName{
    UITextView *textView = (UITextView *)[_nickNameViewController.view viewWithTag:100];
    [_contentArray replaceObjectAtIndex:0 withObject:textView.text];
    
    NSString *postNickName = [self encodeToPercentEscapeString:textView.text];
    NSLog(@"postNickName = %@",postNickName);
    [_PostDict setValue:postNickName forKey:@"nickname"];
    [_nickNameViewController.navigationController popViewControllerAnimated:YES];
    [_tableView reloadData];
}

-(void)saveUserDefault{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"1.1.1"forHTTPHeaderField:@"app_version" ];
    [manager.requestSerializer setValue:@"135150" forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:@"4.3"forHTTPHeaderField:@"os_version" ];
    [manager.requestSerializer setValue:@"A0000049B31052"forHTTPHeaderField:@"openudid" ];
    [manager.requestSerializer setValue:@"Android"forHTTPHeaderField: @"os" ];
    [manager.requestSerializer setValue:@"Keep-Alive"forHTTPHeaderField:@"Connection" ];
    [manager.requestSerializer setValue:@"PHPSESSID=qir0v51ks1sa594kjfgve9gda1;REMEMBERME=QllcQnVuZGxlXFdlYkJ1bmRsZVxFbnRpdHlcVXNlcjpiMkYxZEdoZmQyVmphR0YwWDI4eE5tTjNkV3BqTjJSa2JuZDJiV0Z5WVhCcGFHOW9wlVzFoYzIxQWJHVmtiMjVuTG1sdDoxNDY4NDU4Nzc3OjBjZjUwMTdkNTZlMTI1MTJjODEyMmRmY2FhYjc4NTJlZDFjOWFlNTEzZTAzMDIwNDFlMTFhNWYxNWRlODQ5NjE%3D;"forHTTPHeaderField:@"Cookie" ];
    [manager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding" ];
    [manager.requestSerializer setValue:@"huawei"forHTTPHeaderField:@"channel" ];
    [manager.requestSerializer setValue:@"kudong/android"forHTTPHeaderField:@"User-Agent" ];
    [manager.requestSerializer setValue:@"ledong.im"forHTTPHeaderField:@"Host" ];
    
    
    [manager POST:@"http://ledong.im/api/setting/update_profile" parameters:_PostDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"POST 成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"POST 失败");
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_pickViewIndex == 0) {
        return 2;
    }
      else  return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickViewIndex == 0) {
        if(component == 0)
        return _areaCodeArr.count;
        else
            _modelArea = _areaCodeArr[[_placePick selectedRowInComponent:0]];
            return _modelArea.cities.count;
    }
    else {
        if (component == 0) {
            return 57;
        }
        else if (component == 1)
            return 12;
        else return 30;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(_pickViewIndex == 0){
    return self.view.bounds.size.width/2-20;
    }
    else
        return self.view.bounds.size.width/3-30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(_pickViewIndex == 0){
        if (component == 0) {
            _modelArea = _areaCodeArr[row];
            return _modelArea.name;
        }else
            _modelArea = _areaCodeArr[[_placePick selectedRowInComponent:0]];
            return _modelArea.cities[row][@"name"];
    }
    else{
        if (component == 0) {
            return [NSString stringWithFormat:@"%li",1980+row];
        }
        else if (component == 1){
            return [NSString stringWithFormat:@"%li月",row+1];
        }
        else
            return [NSString stringWithFormat:@"%li",row+1];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(_pickViewIndex == 0){
       if (component == 0) {
          [_placePick reloadComponent:1];
       }
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
