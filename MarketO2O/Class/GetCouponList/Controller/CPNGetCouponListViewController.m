//
//  CPNGetCouponListViewController.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNGetCouponListViewController.h"
#import "CPNGetCouponItemTableViewCell.h"
#import "CPNGetCouponitemModel.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface CPNGetCouponListViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 优惠券列表
 */
@property (nonatomic, strong) UITableView       *tableView;

/**
 优惠券数据源
 */
@property (nonatomic, strong) NSMutableArray    *dataSource;

/**
 分页页码
 */
@property (nonatomic, assign) NSInteger         currentPage;

@end

@implementation CPNGetCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"领取优惠券";
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 0;
    [self requestCouponDataListIsHeaderRefresh:NO isFooterRefresh:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.height = self.view.height;
}

#pragma mark - loadView

/**
 优惠券列表

 @return tableView
 */
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[CPNGetCouponItemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.tableHeaderView =
        _tableView.tableFooterView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WeakSelf
        [_tableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf requestCouponDataListIsHeaderRefresh:YES isFooterRefresh:NO];
        }];
        _tableView.header.updatedTimeHidden = YES;
        [_tableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf requestCouponDataListIsHeaderRefresh:NO isFooterRefresh:YES];
        }];
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - tableViewDelegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNGetCouponItemTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNGetCouponItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                          forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count > indexPath.row) {
        CPNGetCouponitemModel *couponModel = self.dataSource[indexPath.row];
        cell.itemModel = couponModel;
    }
    return cell;
}

#pragma mark - netWorkRequest

/**
 请求优惠券列表

 @param isHeaderRefresh 是否下拉刷新
 @param isFooterRefresh 是否上啦加载更多
 */
- (void)requestCouponDataListIsHeaderRefresh:(BOOL)isHeaderRefresh
                             isFooterRefresh:(BOOL)isFooterRefresh{
    if (isHeaderRefresh) {
        self.currentPage = 0;
    }
    [[CPNHTTPClient instanceClient] requestAccquireCouponListWithPage:self.currentPage
                                                        isNeedLoading:!isHeaderRefresh & !isFooterRefresh
                                                        completeBlock:^(NSArray *couponList, CPNError *error) {
                                                            [self.tableView.header endRefreshing];
                                                            [self.tableView.footer endRefreshing];
                                                            
                                                            if (!error) {
                                                                if (isHeaderRefresh) {
                                                                    [self.dataSource removeAllObjects];
                                                                }
                                                                [self.dataSource addObjectsFromArray:couponList];
                                                                if (self.dataSource.count <= 0) {
                                                                    error = [[CPNError alloc] init];
                                                                    error.errorCode = CPNErrorTypeDataIsBlink;
                                                                    error.errorMessage = CPNErrorMessageDataIsBlink;
                                                                    [self setDefaultErrorTipWithError:error retryBlock:nil];
                                                                }else{
                                                                    self.errorTipView.hidden = YES;
                                                                }
                                                                [self.tableView reloadData];
                                                                if (couponList.count <= 0) {
                                                                    [self.tableView.footer noticeNoMoreData];
                                                                    if (self.dataSource.count <= 0) {
                                                                        self.tableView.footer.hidden = YES;
                                                                    }else{
                                                                        self.tableView.footer.hidden = NO;
                                                                    }
                                                                }else{
                                                                    self.currentPage ++;
                                                                }
                                                            }else{
                                                                WeakSelf
                                                                if ([self isNeedShowErrorTipViewWithError:error]) {
                                                                    [self setDefaultErrorTipWithError:error retryBlock:^{
                                                                        [weakSelf requestCouponDataListIsHeaderRefresh:NO isFooterRefresh:NO];
                                                                    }];
                                                                    [self.tableView reloadData];
                                                                    self.tableView.hidden = YES;
                                                                }
                                                            }
                                                        }];
}

@end
