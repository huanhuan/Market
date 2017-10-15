//
//  SearchResultsController.m
//  LWSearchBarController
//
//  Created by liwei on 2016/4/18.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "LWSearchResultsController.h"
#import "CPNHomePageProductItemTableViewCell.h"
#import "CPNProductDetailViewController.h"

static NSString *cellIdentifier = @"ProductionCellIdentifier";

@interface LWSearchResultsController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray<CPNHomePageProductItemModel *> *productArray;

@end

@implementation LWSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
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
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        [_tableView registerClass:[CPNHomePageProductItemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

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
        [cell hideBuyButton];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.productArray.count > indexPath.row) {
        CPNHomePageProductItemModel *itemModel = self.productArray[indexPath.row];
        CPNProductDetailViewController *productDetail = [[CPNProductDetailViewController alloc] initWithProductModel:itemModel];
        productDetail.hidesBottomBarWhenPushed = YES;
        [self.presentingViewController.navigationController pushViewController:productDetail animated:YES];
//        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];


        //39.918058 longitude:116.397026] name:@"故宫"
        //        CPNSignatureNameViewController *vc = [CPNSignatureNameViewController new];
        //        vc.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:vc animated:YES];
        
        //        [[CPNMapNavManager sharedCPNMapNavManager] mapNavTargetPointWithLatitude:39.918058 longitude:116.397026 name:@"故宫"];
    }
}

- (void)updateSearchResults:(NSArray<CPNHomePageProductItemModel *> *)productions
{
    self.productArray = productions;
    [self.tableView reloadData];
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.isActive) {
        if (searchController.searchBar.text.length > 0) {
            NSLog(@"开始搜索内容为：%@",searchController.searchBar.text);
        }
    }
}

@end
