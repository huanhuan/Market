//
//  CPNMarketPageViewController.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNPointsMarketPageViewController.h"
#import "CPNPointsMarketGoodsItemTableViewCell.h"
#import "CPNPointsMarketCategoryTableViewCell.h"
#import "CPNPointsMarketCategoryModel.h"
#import "CPNProductDetailViewController.h"

static NSString *categoryCellIdentifier = @"categoryCell";
static NSString *goodsItemCellIdentifier = @"goodsCell";

@interface CPNPointsMarketPageViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 顶部静态背景图
 */
@property (nonatomic, strong) UIImageView                   *topImageView;
/**
 左侧商品类别列表
 */
@property (nonatomic, strong) UITableView                   *categoryTableView;
/**
 右侧商品列表
 */
@property (nonatomic, strong) UITableView                   *productTableView;

/**
 商品类别数组
 */
@property (nonatomic, strong) NSArray                       *categoryArray;

/**
 商品数组
 */
@property (nonatomic, strong) NSMutableArray                *productArray;

/**
 当前选中的类别model
 */
@property (nonatomic, strong) CPNPointsMarketCategoryModel  *currentCategoryModel;

/**
 当前页码
 */
@property (nonatomic, assign) NSInteger                     currentPage;

@end

@implementation CPNPointsMarketPageViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.productArray = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 0;
    [self requestProductCategoryList];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.categoryTableView.top =
    self.productTableView.top = self.topImageView.bottom;
    
    self.categoryTableView.height =
    self.productTableView.height = self.view.height - self.productTableView.top;
}


- (void)dealloc{
    
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
 商品类别列表显示的tableView

 @return tableView
 */
- (UITableView *)categoryTableView{
    if (!_categoryTableView) {
        _categoryTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
        _categoryTableView.width = self.view.width/4;
        _categoryTableView.top = self.topImageView.bottom;
        _categoryTableView.height = self.view.height - _categoryTableView.top;
        _categoryTableView.backgroundColor = [UIColor clearColor];
        _categoryTableView.delegate = self;
        _categoryTableView.dataSource = self;
        _categoryTableView.tableHeaderView =
        _categoryTableView.tableFooterView = nil;
        [_categoryTableView registerClass:[CPNPointsMarketCategoryTableViewCell class] forCellReuseIdentifier:categoryCellIdentifier];
        _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_categoryTableView];
    }
    return _categoryTableView;
}



/**
 商品展示列表tableView

 @return tableView
 */
- (UITableView *)productTableView{
    if (!_productTableView) {
        _productTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
        _productTableView.top = self.topImageView.bottom;
        _productTableView.height = self.view.height - _productTableView.top;
        _productTableView.width = self.view.width /4 * 3;
        _productTableView.left = self.categoryTableView.right;
        _productTableView.backgroundColor = [UIColor clearColor];
        _productTableView.delegate = self;
        _productTableView.dataSource = self;
        _productTableView.tableHeaderView =
        _productTableView.tableFooterView = nil;
        [_productTableView registerClass:[CPNPointsMarketGoodsItemTableViewCell class] forCellReuseIdentifier:goodsItemCellIdentifier];
        _productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _productTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        WeakSelf
        [_productTableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf requestGoodsItemListIsHeaderRefresh:YES isFooterRefresh:NO];
        }];
        
        _productTableView.header.updatedTimeHidden = YES;
        [_productTableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf requestGoodsItemListIsHeaderRefresh:NO isFooterRefresh:YES];
        }];
        [self.view addSubview:_productTableView];
    }
    return _productTableView;
}

#pragma mark - tableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categoryArray.count;
    }
    
    if (tableView == self.productTableView) {
        return self.productArray.count;
    }

    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        return [CPNPointsMarketCategoryTableViewCell cellHeight];
    }
    
    if (tableView == self.productTableView) {
        return [CPNPointsMarketGoodsItemTableViewCell cellHeight];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        CPNPointsMarketCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.categoryArray.count > indexPath.row) {
            CPNPointsMarketCategoryModel *categoryModel = self.categoryArray[indexPath.row];
            cell.categoryModel = categoryModel;
        }
        return cell;
    }
    
    if (tableView == self.productTableView) {
        CPNPointsMarketGoodsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsItemCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.productArray.count > indexPath.row) {
            CPNHomePageProductItemModel *itemModel = self.productArray[indexPath.row];
            cell.itemModel = itemModel;
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        CPNPointsMarketCategoryModel *categoryModel = self.categoryArray[indexPath.row];
        if (self.currentCategoryModel == categoryModel) {
            if (self.productArray.count > 0) {
                [self.productTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }else{
            self.currentCategoryModel.isSelected = NO;
            self.currentCategoryModel = categoryModel;
            self.currentCategoryModel.isSelected = YES;
            [self.productArray removeAllObjects];
            [self.categoryTableView reloadData];
            self.currentPage = 0;
            [self requestGoodsItemListIsHeaderRefresh:NO isFooterRefresh:NO];
        }
    }else if (tableView == self.productTableView){
        if (self.productArray.count > indexPath.row) {
            CPNHomePageProductItemModel *itemModel = self.productArray[indexPath.row];
            CPNProductDetailViewController *productDetail = [[CPNProductDetailViewController alloc] initWithProductModel:itemModel];
            productDetail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productDetail animated:YES];
        }
    }
}


#pragma mark - networkRequest
- (void)requestProductCategoryList{
    WeakSelf
    [[CPNHTTPClient instanceClient] requestProductCategoryListWithCompleteBlock:^(NSArray *categoryList, CPNError *error) {
        if (error) {
            if ([self isNeedShowErrorTipViewWithError:error]) {
                self.categoryTableView.hidden = YES;
                self.productTableView.hidden = YES;
                [self setDefaultErrorTipWithError:error
                                       retryBlock:^{
                                           [weakSelf requestProductCategoryList];
                                       }];
            }
        }else{
            self.categoryArray = categoryList;
            if (self.categoryArray.count > 0) {
                self.categoryTableView.hidden = NO;
                
                self.currentCategoryModel = self.categoryArray.firstObject;
                self.currentCategoryModel.isSelected = YES;
                [self.categoryTableView reloadData];
                [self requestGoodsItemListIsHeaderRefresh:NO
                                          isFooterRefresh:NO];
            }else{
                error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataIsBlink;
                error.errorMessage = CPNErrorMessageDataIsBlink;
                [self setDefaultErrorTipWithError:error retryBlock:nil];
            }
        }
    }];
}

- (void)requestGoodsItemListIsHeaderRefresh:(BOOL)isHeaderRefresh
                            isFooterRefresh:(BOOL)isFooterRefresh{
    if (isHeaderRefresh) {
        self.currentPage = 0;
    }
    [[CPNHTTPClient instanceClient] requestTypeProductWithCategoryId:self.currentCategoryModel.id
                                                                page:self.currentPage
                                                       isNeedLoading:!isHeaderRefresh & !isFooterRefresh
                                                       completeBlock:^(NSArray *productList, CPNError *error) {
                                                           [self.productTableView.header endRefreshing];
                                                           [self.productTableView.footer endRefreshing];
                                                           
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
                                                               [self.productTableView reloadData];
                                                               if (productList.count <= 0) {
                                                                   [self.productTableView.footer noticeNoMoreData];
                                                                   if (self.productArray.count <= 0) {
                                                                       self.productTableView.footer.hidden = YES;
                                                                   }else{
                                                                       self.productTableView.footer.hidden = NO;
                                                                   }
                                                               }else{
                                                                   self.currentPage ++;
                                                               }
                                                           }else{
                                                               WeakSelf
                                                               if ([self isNeedShowErrorTipViewWithError:error]) {
                                                                   [self setDefaultErrorTipWithError:error retryBlock:^{
                                                                       [weakSelf requestGoodsItemListIsHeaderRefresh:NO isFooterRefresh:NO];
                                                                   }];
                                                                   self.productTableView.hidden = YES;
                                                               }
                                                           }
                                                       }];
}



@end
