//
//  SJNavigationAlphaController.m
//  SJNavgationBarAlpha
//
//  Created by SPIREJ on 16/1/21.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJNavigationAlphaController.h"
#import "UINavigationBar+Awesome.h"

#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight  [UIScreen mainScreen].bounds.size.height
#define cellHeight 60

//导航栏的背景颜色
#define kNavigationBarColor    [UIColor colorWithRed:238/255.0 green:94/255.0 blue:94/255.0 alpha:1]

#define kItems @[@"HiBOasd",@"Hasdhjbaj",@"Hsjhdyw",@"Jsjdak",@"Jack",@"Miasd",@"Masdhjbaj",@"Money",@"Msoshyw", @"Ssanat", @"Sdouua", @"Sdouua", @"Sdouua", @"Sdouua", @"Sdouua", @"Sdouua", @"Sdouua", @"Wangjiba"]

@interface SJNavigationAlphaController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
{
    UILabel *_titleLabel;
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *bgImageView;
@property(nonatomic, copy)NSMutableArray *dataSourceArr;

@end

@implementation SJNavigationAlphaController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
        _bgImageView.image = [UIImage imageNamed:@"bgImage"];
    }
    return _bgImageView;
}
- (NSMutableArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        _dataSourceArr = [[NSMutableArray alloc] initWithArray:kItems];
    }
    return _dataSourceArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setUpNavigationBar];
    //去除背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    self.view.backgroundColor = [UIColor grayColor];

    [self tableView];
    [self bgImageView];
    [self dataSourceArr];
    [self setUpUI];

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.bgImageView;
}

- (void)setUpUI{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _titleLabel.text = @"卡美森萨克";
    _titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0];
    self.navigationItem.titleView = _titleLabel;
}

//设置navigationBar透明
- (void)setUpNavigationBar
{
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - UIScrollViewDelegate
//修改navigationBar的背景颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = kNavigationBarColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -20 ) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        if (offsetY > 50) {
            CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
            _titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:alpha];
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        } else {
            [self setUpNavigationBar];
            _titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0];
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        }
    }
}


//每组显示多少行cell数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}
//cell内容设置，属性设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifily = @"cellIdentifily";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifily];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifily];
    }
    cell.textLabel.text = _dataSourceArr[indexPath.row];
    return cell;
}

// Variable height support
//cell 的高度（每组可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
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
