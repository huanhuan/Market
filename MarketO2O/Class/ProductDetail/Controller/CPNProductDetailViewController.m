//
//  CPNProductDetailViewController.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNProductDetailViewController.h"
#import "CPNProductDetailInfoView.h"
#import "CPNHomePageProductItemModel.h"
#import "UIImageView+WebCache.h"
#import "CPNProductStarView.h"
#import "CPNProductDescriptionView.h"
#import "SDCycleScrollView.h"
#import "CPNProductionDetailBottonView.h"
#import "CPNShopingCartManager.h"
#import "CPNGoodsPaymentViewController.h"
#import "CPNShopingCartItemModel.h"
#import "CPNShoppingCartViewController.h"
#import "CPNGoodsPaymentManager.h"
@interface CPNProductDetailViewController ()

/**
 商品详情页滚动背景
 */
@property (nonatomic, strong) UIScrollView                  *scrollView;

/**
 底部操作View
 */
@property (nonatomic, strong)CPNProductionDetailBottonView *bottomView;

/**
 商品图片显示
 */
@property (nonatomic, strong) SDCycleScrollView                   *productImageViews;
/**
 商品信息显示
 */
@property (nonatomic, strong) CPNProductDetailInfoView      *productInfoView;

/**
 商品评分信息显示
 */
@property (nonatomic, strong) CPNProductStarView            *productStarView;

/**
 商品描述
 */
@property (nonatomic, strong) CPNProductDescriptionView     *productDescView;

/**
 商品数据model
 */
@property (nonatomic, strong) CPNHomePageProductItemModel   *productModel;

@end

@implementation CPNProductDetailViewController

- (instancetype)initWithProductModel:(CPNHomePageProductItemModel *)productModel{
    self = [super init];
    if (self) {
        self.productModel = productModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品介绍";
    self.productImageView.hidden =
    self.productInfoView.hidden =
    self.productStarView.hidden =
    self.productDescView.hidden =
    self.bottomView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.scrollView.height = self.view.height;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.scrollView.height + 1, self.productDescView.bottom + 10));
}

#pragma mark productionDetailBottomDelegate
- (void)addShopCar
{
    if (self.productModel) {
        [[CPNShopingCartManager sharedCPNShopingCartManager] addToShopingCart:self.productModel];
    }
    [SVProgressHUD showInfoWithStatus:@"加入购物车成功！"];
}
- (void)gotoShopCar
{
    [[CPNShopingCartManager sharedCPNShopingCartManager] gotoShopingCartVC];
}
- (void)buyNow
{
    CPNShopingCartItemModel *model = [CPNShopingCartItemModel new];
    model.count = 1;
    model.id = self.productModel.id;
    model.name = self.productModel.name;
    model.desc = self.productModel.desc;
    model.imageUrl = self.productModel.imageUrl;
    model.points = self.productModel.points;
    [[CPNGoodsPaymentManager sharedCPNGoodsPaymentManager] gotoGoodsPaymentVC:@[model]];
    
}


#pragma mark - loadView
/**
 底部操作view
 
 @return CPNProductionDetailBottonView
 */
- (CPNProductionDetailBottonView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[CPNProductionDetailBottonView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self.view);
            make.height.equalTo(@60);
        }];
        _bottomView.delegate = (id<productionDetailBottomDelegate>)self;
    }
    return _bottomView;
}

/**
 商品详情滚动背景

 @return scrollView
 */
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
            
        }];
    }
    return _scrollView;
}


/**
 商品图片显示

 @return imageView
 */
- (SDCycleScrollView *)productImageView{
    if (!_productImageViews) {
//        productImageViews = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.width)];
        _productImageViews = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0 , self.scrollView.width, self.scrollView.width) delegate:nil placeholderImage:[UIImage imageNamed:@"图片默认图"]];
        [_productImageViews setImageURLStringsGroup:@[[NSURL URLWithString:self.productModel.imageUrl]]];
//        _productImageView.backgroundColor = CPNCommonOrangeColor;
//        [_productImageView sd_setImageWithURL:[NSURL URLWithString:self.productModel.imageUrl] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
        [self.scrollView addSubview:_productImageViews];
    }
    return _productImageViews;
}


/**
 商品详细信息显示

 @return view
 */
- (CPNProductDetailInfoView *)productInfoView{
    if (!_productInfoView) {
        _productInfoView = [[CPNProductDetailInfoView alloc] initWithFrame:CGRectMake(0, self.productImageView.bottom, self.scrollView.width, [CPNProductDetailInfoView productInfoViewHeight])];
        _productInfoView.backgroundColor = CPNCommonWhiteColor;
        _productInfoView.productModel = self.productModel;
        [self.scrollView addSubview:_productInfoView];
    }
    return _productInfoView;
}


/**
 商品评分信息显示

 @return view
 */
- (CPNProductStarView *)productStarView{
    if (!_productStarView) {
        _productStarView = [[CPNProductStarView alloc] initWithFrame:CGRectMake(0, self.productInfoView.bottom + 10, self.scrollView.width, [CPNProductStarView productStarViewHeight])];
        _productStarView.backgroundColor = CPNCommonWhiteColor;
        _productStarView.productModel = self.productModel;
        [self.scrollView addSubview:_productStarView];
    }
    return _productStarView;
}


/**
 商品描述文案显示

 @return view
 */
- (CPNProductDescriptionView *)productDescView{
    if (!_productDescView) {
        _productDescView = [[CPNProductDescriptionView alloc] initWithFrame:CGRectMake(0, self.productStarView.bottom + 10, self.scrollView.width, 0)];
        _productDescView.backgroundColor = CPNCommonWhiteColor;
        _productDescView.productModel = self.productModel;
        [self.scrollView addSubview:_productDescView];
    }
    return _productDescView;
}

#pragma mark - networkRequest

- (void)requestproductDetailInfo{
    WeakSelf
    self.scrollView.hidden = YES;
    [[CPNHTTPClient instanceClient] requestProductDetailInfoWithProductId:self.productModel.id
                                                           completebBlock:^(CPNHomePageProductItemModel *productModel, CPNError *error) {
                                                               if (error) {
                                                                   self.scrollView.hidden = YES;
                                                                   if ([self isNeedShowErrorTipViewWithError:error]) {
                                                                       [self setDefaultErrorTipWithError:error retryBlock:^{
                                                                           [weakSelf requestproductDetailInfo];
                                                                       }];
                                                                   }
                                                               }else{
                                                                   self.productModel = productModel;
                                                                   self.errorTipView.hidden = YES;
                                                                   self.scrollView.hidden = NO;
                                                                   self.productInfoView.productModel = self.productModel;
                                                                   self.productStarView.productModel = self.productModel;
                                                                   self.productDescView.productModel = self.productModel;
                                                               }
                                                           }];
}

@end
