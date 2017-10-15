//
//  CPNCouponListSubViewController.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNCouponListSubViewController.h"
#import "CPNCouponListItemTableViewCell.h"
#import "CPNCouponListCouponItemModel.h"
#import "CPNMapNavManager.h"

#import "CPNTabBarViewController.h"
#import "CPNContractSignViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface CPNCouponListSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, assign) BOOL              isFirstRequest;
@property (nonatomic, assign) NSInteger         currentPage;

@end

@implementation CPNCouponListSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.isFirstRequest = YES;
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.height = self.view.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        [_tableView registerClass:[CPNCouponListItemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.tableHeaderView =
        _tableView.tableFooterView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WeakSelf
        [_tableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf requestCouponDataListIsHeaderRefresh:YES isFooterRefresh:NO];
        }];
        
        [_tableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf requestCouponDataListIsHeaderRefresh:NO isFooterRefresh:YES];
        }];
        _tableView.header.updatedTimeHidden = YES;
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
    return [CPNCouponListItemTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNCouponListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                          forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count > indexPath.row) {
        CPNCouponListCouponItemModel *couponModel = self.dataSource[indexPath.row];
        cell.couponModel = couponModel;
        cell.index = self.index;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPNCouponListCouponItemModel *couponModel = self.dataSource[indexPath.row];
//    [[CPNHTTPClient instanceClient] requestContractWithShopId:couponModel.shopId completeBlock:^(NSString *ContractImageUrl, CPNError *error) {
//        if (ContractImageUrl) {
//            CPNContractSignViewController *VC = [[CPNContractSignViewController alloc] initWithContractImageUrl:ContractImageUrl];
//            VC.hidesBottomBarWhenPushed = YES;
//            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
////            self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
//            [((UINavigationController*)(delegate.tabBarController.selectedViewController)) pushViewController:VC animated:YES];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//    }];
    if (couponModel.latitude && couponModel.longitude) {
        [[CPNMapNavManager sharedCPNMapNavManager] mapNavTargetPointWithLatitude:[couponModel.latitude floatValue] longitude:[couponModel.longitude floatValue] name:couponModel.shopName];
    }
}
#pragma mark - netWorkRequest

/**
 刷新页面数据
 */
- (void)refreshCouponDataList{
    if (self.isFirstRequest) {
        [self requestCouponDataListIsHeaderRefresh:NO isFooterRefresh:NO];
        self.isFirstRequest = NO;
    }
}

/**
 请求优惠券列表
 
 @param isHeaderRefresh 是否下拉刷新
 */
- (void)requestCouponDataListIsHeaderRefresh:(BOOL)isHeaderRefresh
                             isFooterRefresh:(BOOL)isFooterRefresh{
    if (isHeaderRefresh) {
        self.currentPage = 0;
    }
    [[CPNHTTPClient instanceClient] requestUserCouponListWithStatus:self.index
                                                               page:self.currentPage
                                                      isShowLoading:!isHeaderRefresh & !isFooterRefresh
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
