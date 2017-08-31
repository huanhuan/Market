//
//  CPNOrderListViewController.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNOrderListViewController.h"
#import "CPNOrderListItemTableViewCell.h"
#import "CPNOrderListItemModel.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface CPNOrderListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIImageView       *topImageView;
@property (nonatomic, strong) NSMutableArray    *orderArray;
@property (nonatomic, assign) NSInteger         currentPage;

@end

@implementation CPNOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.orderArray = [NSMutableArray arrayWithCapacity:0];
    [self requestOrderListIsHeaderRefresh:NO isFooterRefresh:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.top = self.topImageView.bottom;
    self.tableView.height = self.view.height - self.tableView.top;
}

#pragma mark - loadView

/**
 顶部背景图
 
 @return imageView
 */
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
        _topImageView.backgroundColor = CPNCommonOrangeColor;
        //TODO:图片
        _topImageView.image = [UIImage imageNamed:@""];
        [self.view addSubview:_topImageView];
    }
    return _topImageView;
}


/**
 订单列表

 @return tableView
 */
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.top = self.topImageView.bottom;
        _tableView.height = self.view.height - _tableView.top;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = nil;
        _tableView.tableHeaderView = nil;
        [_tableView registerClass:[CPNOrderListItemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WeakSelf
        [_tableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf requestOrderListIsHeaderRefresh:YES isFooterRefresh:NO];
        }];
        _tableView.header.updatedTimeHidden = YES;
        [_tableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf requestOrderListIsHeaderRefresh:NO isFooterRefresh:YES];
        }];
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - tableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNOrderListItemTableViewCell cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNOrderListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                          forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.orderArray.count > indexPath.row) {
        CPNOrderListItemModel *itemModel = self.orderArray[indexPath.row];
        cell.orderModel = itemModel;
    }
    return cell;
}


#pragma mark - networkRequest

/**
 请求订单列表

 @param isHeaderRefresh 是否是下拉刷新
 @param isFooterRerfesh 是否是上拉加载更多
 */
- (void)requestOrderListIsHeaderRefresh:(BOOL)isHeaderRefresh
                        isFooterRefresh:(BOOL)isFooterRerfesh{
    if (isHeaderRefresh) {
        self.currentPage = 0;
    }
    WeakSelf
    [[CPNHTTPClient instanceClient] requestUserOrderListWithStatus:0
                                                              page:self.currentPage
                                                     isNeedLoading:!isHeaderRefresh & !isFooterRerfesh
                                                     completeBlock:^(NSArray *orderList, CPNError *error) {
                                                         [self.tableView.header endRefreshing];
                                                         [self.tableView.footer endRefreshing];

                                                         if (error) {
                                                             if ([self isNeedShowErrorTipViewWithError:error]) {
                                                                 self.tableView.hidden = YES;
                                                                 [self setDefaultErrorTipWithError:error retryBlock:^{
                                                                     [weakSelf requestOrderListIsHeaderRefresh:NO
                                                                                               isFooterRefresh:NO];
                                                                 }];
                                                             }
                                                         }else{
                                                             if (isHeaderRefresh) {
                                                                 [self.orderArray removeAllObjects];
                                                             }
                                                             [self.orderArray addObjectsFromArray:orderList];
                                                             if (self.orderArray.count <= 0) {
                                                                 error = [[CPNError alloc] init];
                                                                 error.errorCode = CPNErrorTypeDataIsBlink;
                                                                 error.errorMessage = CPNErrorMessageDataIsBlink;
                                                                 [self setDefaultErrorTipWithError:error retryBlock:nil];
                                                             }else{
                                                                 self.errorTipView.hidden = YES;
                                                             }
                                                             [self.tableView reloadData];
                                                             if (orderList.count <= 0) {
                                                                 [self.tableView.footer noticeNoMoreData];
                                                                 if (self.orderArray.count <= 0) {
                                                                     self.tableView.footer.hidden = YES;
                                                                 }else{
                                                                     self.tableView.footer.hidden = NO;
                                                                 }
                                                             }else{
                                                                 self.currentPage ++;
                                                             }
                                                         }
                                                     }];
}

@end
