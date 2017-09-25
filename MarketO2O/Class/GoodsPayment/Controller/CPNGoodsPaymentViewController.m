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

@interface CPNGoodsPaymentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) CPNGoodsPayMentBottonView     *bottonView;
@end

static NSString *cellIdentifier = @"cellIdentifier";

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

#pragma mark - tableViewDelegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectedProductionArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNGoodsPaymentCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNGoodsPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                   forIndexPath:indexPath];
    if (self.selectedProductionArray.count > indexPath.row) {
        CPNShopingCartItemModel *itemModel = self.selectedProductionArray[indexPath.row];
        cell.itemModel = itemModel;
    }
    return cell;
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
        [_tableView registerClass:[CPNGoodsPaymentCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CPNGoodsPayMentBottonView *)bottonView
{
    if (!_bottonView) {
        _bottonView = [[CPNGoodsPayMentBottonView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_bottonView];
    }
    return _bottonView;
}
@end
