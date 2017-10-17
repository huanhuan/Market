//
//  CPNContractListVIewController.m
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNContractListVIewController.h"
#import "CPNContractListCell.h"
#import "CPNContractModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CPNContractSignViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface CPNContractListVIewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong)NSArray<CPNContractModel *> *contractsArray;

@end

@implementation CPNContractListVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合同列表";
    [self.mainTableView reloadData];
    [[CPNHTTPClient instanceClient] requestContractWithCompleteBlock:^(NSArray *Contracts, CPNError *error) {
        if (Contracts) {
            self.contractsArray = Contracts;
            [self.mainTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = CPNCommonContrllorBackgroundColor;
        [_mainTableView registerClass:[CPNContractListCell class] forCellReuseIdentifier:cellIdentifier];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}
#pragma mark - tableViewDelegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contractsArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        CPNContractModel *itemModel = self.contractsArray[indexPath.row];
        [((CPNContractListCell*)cell).shopName setText:itemModel.shopName];
        [((CPNContractListCell*)cell).shopId setText:[NSString stringWithFormat:@"商家ID：%ld",itemModel.shopId]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNContractListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                   forIndexPath:indexPath];
    if (self.contractsArray.count > indexPath.row) {
        CPNContractModel *itemModel = self.contractsArray[indexPath.row];
        [cell.shopName setText:itemModel.shopName];
        [cell.shopId setText:[NSString stringWithFormat:@"商家ID：%ld",itemModel.shopId]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CPNContractModel *itemModel = self.contractsArray[indexPath.row];
    CPNContractSignViewController *signVC = [[CPNContractSignViewController alloc] initWithContractImageUrl:itemModel.contractUrl shopId:itemModel.shopId];
    signVC.title = itemModel.shopName;
    [self.navigationController pushViewController:signVC animated:YES];
    
}


@end
