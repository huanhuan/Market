//
//  CPNHomePageViewController.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHomePageViewController.h"
#import "CPNHomeModuleActionView.h"
#import "CPNHomePageProductItemTableViewCell.h"
#import "CPNHomePageSectionHeaderView.h"
#import "CPNGetCouponListViewController.h"
#import "UINavigationController+StatusBar.h"
#import "CPNProductDetailViewController.h"
#import "CPNAlertView.h"
#import "CPNTabBarViewController.h"

#import "CPNMapNavManager.h"
#import "CPNSignatureNameViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *headerIdentifier = @"headerIdentifer";

@interface CPNHomePageViewController ()<UITableViewDelegate, UITableViewDataSource>


/**
 首页顶部显示的头
 */
@property (nonatomic, strong) UIView                        *headerView;
/**
 首页banner轮播图
 */
@property (nonatomic, strong) UIImageView                   *topImageView;
/**
 首页顶部操作模块view
 */
@property (nonatomic, strong) CPNHomeModuleActionView       *moduleActionView;
/**
 商品展示列表
 */
@property (nonatomic, strong) UITableView                   *tableView;
/**
 数据model
 */
@property (nonatomic, strong) NSMutableArray                *productArray;

/**
 当前页码
 */
@property (nonatomic, assign) NSInteger                     currentPage;

@end

@implementation CPNHomePageViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"顶立方积分商城";
    self.topImageView.hidden =
    self.moduleActionView.hidden = NO;
    self.view.backgroundColor = CPNCommonLineLayerColorColor;
    self.productArray = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 0;
    [self requestGoodsListIsHeaderRefresh:NO isFooterRefrsh:NO];
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.height = self.view.height - self.tableView.top;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = CPNCommonRedColor;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CPNCommonWhiteColor, NSForegroundColorAttributeName,CPNCommonFontEighteenSize,NSFontAttributeName, nil]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CPNCommonMiddleBlackColor, NSForegroundColorAttributeName,CPNCommonFontEighteenSize,NSFontAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = CPNCommonWhiteColor;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)dealloc{
    
}


#pragma mark - loadView

/**
 顶部banbner和模块按钮显示的view

 @return view
 */
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 230)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}


/**
 顶部显示的轮播banner

 @return view
 */
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.headerView.width, 130)];
        _topImageView.backgroundColor = CPNCommonRedColor;
        //TODO:图片
        _topImageView.image = [UIImage imageNamed:@""];
        [self.headerView addSubview:_topImageView];
    }
    return _topImageView;
}


/**
 模块按钮显示的view

 @return view
 */
- (CPNHomeModuleActionView *)moduleActionView{
    if (!_moduleActionView) {
        _moduleActionView = [[CPNHomeModuleActionView alloc] initWithFrame:CGRectMake(0, self.topImageView.bottom, self.headerView.width, 100)];
        _moduleActionView.backgroundColor = CPNCommonWhiteColor;
        WeakSelf
        _moduleActionView.clickButtonAction = ^(NSInteger index) {
            [weakSelf clickModuleButtonActionWithIndex:index];
        };
        [self.headerView addSubview:_moduleActionView];
    }
    return _moduleActionView;
}



/**
 商品显示的列表

 @return tableView
 */
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CPNCommonContrllorBackgroundColor;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        [_tableView registerClass:[CPNHomePageProductItemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WeakSelf
        [_tableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf requestGoodsListIsHeaderRefresh:YES isFooterRefrsh:NO];
        }];
        [_tableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf requestGoodsListIsHeaderRefresh:NO isFooterRefrsh:YES];
        }];
        _tableView.header.updatedTimeHidden = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - tableViewDelegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNHomePageProductItemTableViewCell cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNHomePageProductItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                              forIndexPath:indexPath];
    if (self.productArray.count > indexPath.row) {
        CPNHomePageProductItemModel *itemModel = self.productArray[indexPath.row];
        cell.itemModel = itemModel;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.productArray.count > indexPath.row) {
        CPNHomePageProductItemModel *itemModel = self.productArray[indexPath.row];
        CPNProductDetailViewController *productDetail = [[CPNProductDetailViewController alloc] initWithProductModel:itemModel];
        productDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productDetail animated:YES];
        //39.918058 longitude:116.397026] name:@"故宫"
//        CPNSignatureNameViewController *vc = [CPNSignatureNameViewController new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    
//        [[CPNMapNavManager sharedCPNMapNavManager] mapNavTargetPointWithLatitude:39.918058 longitude:116.397026 name:@"故宫"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [CPNHomePageSectionHeaderView sectionHeaderHeight];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CPNHomePageSectionHeaderView *headerView = (CPNHomePageSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!headerView) {
        headerView = [[CPNHomePageSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [CPNHomePageSectionHeaderView sectionHeaderHeight])];
        headerView.backgroundColor = [UIColor clearColor];
    }
    headerView.title = @"热卖推荐";
    return headerView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - networkRequest

/**
 请求商品列表接口

 @param isHeaderRefresh 是否是下拉刷新
 */
- (void)requestGoodsListIsHeaderRefresh:(BOOL)isHeaderRefresh
                         isFooterRefrsh:(BOOL)isFooterRefresh{
    if (isHeaderRefresh) {
        self.currentPage = 0;
    }
    [[CPNHTTPClient instanceClient] requestHomePageHotProductWithPage:self.currentPage
                                                        isNeedLoading:!isHeaderRefresh & !isFooterRefresh
                                                        completeBlock:^(NSArray *productList, CPNError *error) {
                                                            [self.tableView.header endRefreshing];
                                                            [self.tableView.footer endRefreshing];
                                                            
                                                            if (!error) {
                                                                if (isHeaderRefresh) {
                                                                    [self.productArray removeAllObjects];
                                                                }
                                                                [self.productArray addObjectsFromArray:productList];
                                                                if (self.productArray.count <= 0) {
                                                                    error = [[CPNError alloc] init];
                                                                    error.errorCode = CPNErrorTypeDataIsBlink;
                                                                    error.errorMessage = CPNErrorMessageDataIsBlink;
                                                                    [self setDefaultErrorTipWithError:error retryBlock:nil];
                                                                }else{
                                                                    self.errorTipView.hidden = YES;
                                                                }
                                                                [self.tableView reloadData];
                                                                if (productList.count <= 0) {
                                                                    [self.tableView.footer noticeNoMoreData];
                                                                    if (self.productArray.count <= 0) {
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
                                                                        [weakSelf requestGoodsListIsHeaderRefresh:NO isFooterRefrsh:NO];
                                                                    }];
                                                                    [self.tableView reloadData];
                                                                    self.tableView.hidden = YES;
                                                                }
                                                            }
                                                        }];
}


#pragma mark - buttonAction
- (void)clickModuleButtonActionWithIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            CPNGetCouponListViewController *getCouponList = [[CPNGetCouponListViewController alloc] init];
            getCouponList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:getCouponList animated:YES];
        }
            break;
        case 1:{
            CPNAlertView *alertView = [[CPNAlertView alloc] initWithTitle:@"提示"
                                                                  message:@"此功能即将上线，敬请期待！"
                                                             confirmTitle:@"知道了"];
            [alertView show];
        }
            break;
        case 2:{
            NSString *telPhone = @"0755-26408220";
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", telPhone]];
            double version = [ [[UIDevice currentDevice] systemVersion] doubleValue];
            if (version < 8.0) {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+86%@", telPhone]];
            }
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case 3:{
            [self.appDelegate.tabBarController setSelectedIndex:1];
        }
            break;
            
            
        default:
            break;
    }
}

@end
