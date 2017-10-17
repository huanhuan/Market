//
//  CPNGoodsPaymentViewController.m
//  MarketO2O
//
//  Created by phh on 2017/9/24.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNGoodsPaymentViewController.h"
#import "CPNGoodsPaymentCell.h"
#import "CPNGoodsPayMentBottonView.h"
#import "CPNUserAddressInfoModel.h"
#import "CPNAddAdressViewController.h"
#import "CPNAddressTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CPNShopingCartManager.h"
#import "CPNOrderListViewController.h"
@interface CPNGoodsPaymentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) CPNGoodsPayMentBottonView     *bottonView;
@property (nonatomic, strong) CPNUserAddressInfoModel       *userAddressInfoModel;
@property (nonatomic, assign) float needMoney;
@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *addressIdentifier = @"addressIdentifier";

@implementation CPNGoodsPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算页";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
    }];

    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger totalPoint = delegate.loginUserModel.points;
    NSInteger goodsNeedPoint = 0;
    for (CPNShopingCartItemModel *itemModel in self.selectedProductionArray) {
        goodsNeedPoint += itemModel.points*itemModel.count;
    }
    NSInteger remainPoint = 0;
    float needMoney = 0;
    NSInteger payPoint = goodsNeedPoint;
    if (totalPoint > goodsNeedPoint) {
        needMoney = 0;
        remainPoint = totalPoint - goodsNeedPoint;
    }else
    {
        needMoney = (goodsNeedPoint - totalPoint)/10.0f;
        payPoint = totalPoint;
    }
    self.needMoney = needMoney;
    [self.bottonView update:payPoint remainPoints:remainPoint needPayMoney:needMoney];
    
//    [self.bottonView update:goodsNeedPoint goodsNeedPoints:goodsNeedPoint needPayMoney:needMoney];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.userAddressInfoModel = [[CPNDataBase defaultDataBase] getUserAddressInfo];
    if (!self.userAddressInfoModel) {
        CPNAddAdressViewController *VC = [CPNAddAdressViewController new];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectedProductionArray.count + 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        WeakSelf;
        return [self.tableView fd_heightForCellWithIdentifier:addressIdentifier cacheByIndexPath:indexPath  configuration:^(UITableViewCell *cell)
                {
                    [(CPNAddressTableViewCell *)cell setUserAddressInfoModel:weakSelf.userAddressInfoModel];
                }];
    }else
        return [CPNGoodsPaymentCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:addressIdentifier forIndexPath:indexPath];
        [(CPNAddressTableViewCell *)cell setUserAddressInfoModel:self.userAddressInfoModel];
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                    forIndexPath:indexPath];
        if (self.selectedProductionArray.count + 1 > indexPath.row) {
            CPNShopingCartItemModel *itemModel = self.selectedProductionArray[indexPath.row - 1];
            [(CPNGoodsPaymentCell *)cell setItemModel:itemModel];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CPNAddAdressViewController *vc = [[CPNAddAdressViewController alloc] init];
        [vc changeAddress:self.userAddressInfoModel];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 商品显示的列表
 
 @return tableView
 */
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CPNCommonContrllorBackgroundColor;
        [_tableView registerClass:[CPNGoodsPaymentCell class] forCellReuseIdentifier:cellIdentifier];
        [_tableView registerClass:[CPNAddressTableViewCell class] forCellReuseIdentifier:addressIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CPNGoodsPayMentBottonView *)bottonView
{
    if (!_bottonView) {
        _bottonView = [[CPNGoodsPayMentBottonView alloc] initWithFrame:CGRectZero];
        _bottonView.delegate = (id<CPNGoodsPayMentBottonDelegate>)self;
        [self.view addSubview:_bottonView];
    }
    return _bottonView;
}

#pragma mark CPNGoodsPayMentBottonDelegate
- (void)confirmButtonClick
{
    if (self.needMoney > 0) {
#warning 微信支付
    }else
    {
        
        NSString *goodsId = nil;
        NSMutableDictionary __block *dic = [NSMutableDictionary new];
        [self.selectedProductionArray enumerateObjectsUsingBlock:^(CPNShopingCartItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dic setObject:[NSString stringWithFormat:@"%ld", obj.count] forKey:obj.id];
        }];
        goodsId = [dic mj_JSONString];
        [[CPNHTTPClient instanceClient] requestBuyProductWithProductId:goodsId name:self.userAddressInfoModel.name phone:self.userAddressInfoModel.telephoneNumber address:[NSString stringWithFormat:@"%@%@", self.userAddressInfoModel.city, self.userAddressInfoModel.address] completeBlock:^(CPNResponse *response, CPNError *error) {
            if (!error) {
                [self.selectedProductionArray enumerateObjectsUsingBlock:^(CPNShopingCartItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [[CPNShopingCartManager sharedCPNShopingCartManager] deleteShopingCart:obj];
//                    [SVProgressHUD showInfoWithStatus:@"下单成功！"];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    CPNAlertView *alertView = [[CPNAlertView alloc] initWithTitle:@"恭喜您成功下单"
                                                                          message:@"商家将在3个工作日内发货，请留意快递信息，若有疑问，可拨打客服热线"
                                                                     confirmTitle:@"查看我的订单"];
                    __weak typeof(alertView) weakAlertView = alertView;
                    alertView.confirmButtonAction = ^{
                        CPNOrderListViewController *orderList = [[CPNOrderListViewController alloc] init];
                        orderList.hidesBottomBarWhenPushed = YES;
                        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//                        UINavigationController *navigation = self.navigationController;
                        [delegate.navigationVC pushViewController:orderList animated:YES];
                        [weakAlertView dismiss];
                    };
                    [alertView show];
                }];
                
            }
        }];
    }
}

@end
