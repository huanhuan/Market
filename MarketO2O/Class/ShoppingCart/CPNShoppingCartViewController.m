//
//  CPNShoppingCartViewController.m
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNShoppingCartViewController.h"
#import "CPNDataBase.h"
#import "CPNShopingCartItemModel.h"
#import "CPNShopingCartItemCell.h"
#import "CPNShopingCartManager.h"

#import "CPNShopingCartBottonView.h"

static NSString *cellIdentifier = @"cellIdentifier";


@interface CPNShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray<CPNShopingCartItemModel *> *allProductionsArray;

@property (nonatomic, strong)NSMutableArray<CPNShopingCartItemModel *> *selectedProductionArray;

@property (nonatomic, strong) UITableView                   *tableView;

@property (nonatomic, strong)CPNShopingCartBottonView *bottonView;

@end

@implementation CPNShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
    }];
    
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@45);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.allProductionsArray = [[[CPNDataBase defaultDataBase] getAllProductionInShopCart] mutableCopy];
    self.selectedProductionArray = [NSMutableArray new];
    [self updateView];
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
        [_tableView registerClass:[CPNShopingCartItemCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CPNShopingCartBottonView *)bottonView
{
    if (!_bottonView) {
        _bottonView = [[CPNShopingCartBottonView alloc] initWithFrame:CGRectZero];
        _bottonView.delegate = (id<CPNShopingCartBottonViewDelegate>)self;
        [self.view addSubview:_bottonView];
    }
    return _bottonView;
}

- (void)updateSelectedProductions
{
    [self.selectedProductionArray removeAllObjects];
    for (CPNShopingCartItemModel *itemModel in self.allProductionsArray) {
        if (itemModel.selected) {
            [self.selectedProductionArray addObject:itemModel];
        }
    }
}

- (void)updateView
{
    [self updateSelectedProductions];
    [self updateBottonView];
    [self.tableView reloadData];
}

- (void)updateBottonView
{
    NSUInteger count = 0;
    NSUInteger points = 0;
    for (CPNShopingCartItemModel *itemModel in self.allProductionsArray) {
        if (itemModel.selected) {
            count++;
            points+=itemModel.points * itemModel.count;
        }
    }
    if (self.selectedProductionArray.count != 0 && self.selectedProductionArray.count == self.allProductionsArray.count) {
        [self.bottonView updateSelectNumber:count points:points hasSelectedAll:YES];
    }else
    {
        [self.bottonView updateSelectNumber:count points:points hasSelectedAll:NO];
    }
}

#pragma mark - tableViewDelegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allProductionsArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNShopingCartItemCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNShopingCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                                forIndexPath:indexPath];
    if (self.allProductionsArray.count > indexPath.row) {
        CPNShopingCartItemModel *itemModel = self.allProductionsArray[indexPath.row];
        cell.itemModel = itemModel;
    }
    cell.delegate = (id<CPNShopingCartItemCellDelegate>)self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPNShopingCartItemModel *model = [self.allProductionsArray objectAtIndex:indexPath.row];
    [[CPNShopingCartManager sharedCPNShopingCartManager] deleteShopingCart:model];
    if (model.selected) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateView];
            });
    }
    // 删除模型
    [self.allProductionsArray removeObjectAtIndex:indexPath.row];
    
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark CPNShopingCartItemCellDelegate
- (void)selecteItemModel:(CPNShopingCartItemModel *)itemModel status:(BOOL)selected
{
    itemModel.selected = selected;
    [self updateSelectedProductions];
    [self updateBottonView];
}

- (void)updateItemModelCount:(CPNShopingCartItemModel *)itemModel
{
    if (itemModel.selected) {
        [self updateView];
    }
}

#pragma mark CPNShopingCartBottonViewDelegate
- (void)selectedAll:(BOOL)selected
{
    for (CPNShopingCartItemModel *itemModel in self.allProductionsArray) {
        itemModel.selected = selected;
    }
    [self updateView];
}


@end
