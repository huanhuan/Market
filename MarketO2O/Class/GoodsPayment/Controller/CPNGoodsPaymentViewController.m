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

@interface CPNGoodsPaymentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) CPNGoodsPayMentBottonView     *bottonView;
@property (nonatomic, strong) CPNUserAddressInfoModel       *userAddressInfoModel;
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
        return [self.tableView fd_heightForCellWithIdentifier:addressIdentifier cacheByKey:self.userAddressInfoModel.name  configuration:^(UITableViewCell *cell)
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
#warning 马上下单按钮
}

@end
