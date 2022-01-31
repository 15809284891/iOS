//
//  TestTableViewBehaiverViewController.m
//  LXTextField
//
//  Created by karisli(李雪) on 2020/6/15.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "TestTableViewBehaiverViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface TestTableViewBehaiverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *adjustTableView;
@property (nonatomic,strong)NSMutableArray *datas;
@end
@implementation TestTableViewBehaiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _datas = [NSMutableArray array];
       if (self) {
           for (NSUInteger i = 1; i<= 100; i++) {
           [_datas addObject:@(i)];
           }
       }
    _adjustTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _adjustTableView.delegate = self;
    _adjustTableView.dataSource = self;
//    _adjustTableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    [self initSearchVc];
    [self.view addSubview:_adjustTableView];
    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _adjustTableView.mj_footer = footer;
    [_adjustTableView reloadData];
}

-(void)initSearchVc{
    UISearchController *searchVC = [[UISearchController alloc] init];
    //自动占据导航栏
      searchVC.hidesNavigationBarDuringPresentation = YES;
      //搜索时，背景变暗色
      searchVC.dimsBackgroundDuringPresentation = NO;
      //搜索时,背景变模糊
      searchVC.obscuresBackgroundDuringPresentation = NO;
      //    [searchVC.searchBar sizeToFit];
        searchVC.searchBar.returnKeyType = UIReturnKeySearch;
        searchVC.searchBar.placeholder = NSLocalizedString(@"search", nil);
        //删除searchBar边框线
        searchVC.searchBar.layer.borderWidth = 1;
    #warning 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
        //将searchBar加载一个view上，
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0,searchVC.searchBar.frame.size.width , searchVC.searchBar.frame.size.height)];
        [v addSubview:searchVC.searchBar];
        self.adjustTableView.tableHeaderView = v;
        
}
-(void)loadMoreData{
    NSUInteger index = self.datas.count;
    if (index >=750) {
        [self.adjustTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    for (NSUInteger i = index+1; i<= index+100; i++) {
        [_datas addObject:@(i)];
    }
    [self.adjustTableView reloadData];
    [self.adjustTableView.mj_footer endRefreshing];
}


#pragma mark -tableView datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.datas[indexPath.row]];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
#pragma mark -tableView delegate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
