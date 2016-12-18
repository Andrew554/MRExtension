//
//  MRMainTableView.m
//  QZH
//
//  Created by coderLL on 16/9/17.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "MRMainTableView.h"
#import "SceneTableViewCell.h"
#import "MJRefresh.h"
#import "FindDetailViewController.h"

@interface MRMainTableView()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageNo;
    NSInteger total;
}

@end

@implementation MRMainTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = (SCREENW-16)*0.5 + 75;
        self.delegate = self;
        self.dataSource = self;
        
        [self setUpMjRefresh];
    }
    return self;
}

-(void)setUpMjRefresh{
    _dataArray = [NSMutableArray array];
    pageNo = 1;
    total = 0;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjRefrsh)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"卖力加载中..." forState:MJRefreshStateRefreshing];
    header.automaticallyChangeAlpha = YES;
    self.mj_header = header;
    [self.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjLoadMore)];
    // 设置文字
    [footer setTitle:@"点击加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已全部加载完" forState:MJRefreshStateNoMoreData];
    // 设置footer
    self.mj_footer = footer;
}

- (void)mjRefrsh{
    pageNo = 1;
    [self.mj_footer resetNoMoreData];
    [self getData];
}

- (void)mjLoadMore {
    pageNo++;
    [self getData];
}

#pragma mark - Http
- (void)getData{
    NSDictionary *params = @{@"pageNo":@(pageNo),@"size":@(20)};
    NSString *action = [NSString stringWithFormat:@"%@%zd",ListByTheme,_themeId];
    
    [HttpTool createAsynchronousRequest:action parameters:params success:^(NSDictionary *dic) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        NSArray *tempArr = [dic objectForKey:@"result"];
        if (_dataArray == nil) {
            _dataArray = [NSMutableArray array];
        }
        [_dataArray addObjectsFromArray:tempArr];
        total = [[dic objectForKey:@"total"] integerValue];
        if (total <= _dataArray.count) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
        [self reloadData];
    } failure:^{
    }];
}

#pragma mark - TableView Datasource&Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SceneTableViewCell *cell = [[SceneTableViewCell alloc] getUseableCellWithTableView:self];
    [cell setUpDataWithDict:[_dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FindDetailViewController *vc = [[FindDetailViewController alloc] init];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSInteger sceneID = [dict[@"id"] integerValue];
    vc.sceneId = sceneID;
    [_vc.navigationController pushViewController:vc animated:YES];
}

@end
