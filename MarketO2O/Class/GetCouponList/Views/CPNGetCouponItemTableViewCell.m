//
//  CPNGetCouponItemTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNGetCouponItemTableViewCell.h"
#import "CPNGetCouponitemModel.h"
#import "CPNCouponListManagerViewController.h"

@interface CPNGetCouponItemTableViewCell ()

/**
 优惠券卡片背景
 */
@property (nonatomic, strong) UIView        *cellBackView;
/**
 优惠券图片
 */
@property (nonatomic, strong) UIImageView   *itemImageView;

/**
 优惠券名称label
 */
@property (nonatomic, strong) UILabel       *itemNameLabel;

/**
 优惠券可用商户地址label
 */
@property (nonatomic, strong) UILabel       *itemAddressLabel;

/**
 领取优惠券按钮
 */
@property (nonatomic, strong) UIButton      *itemGetButton;


@end

@implementation CPNGetCouponItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.cellBackView.backgroundColor = CPNCommonWhiteColor;
    }
    return self;
}


#pragma mark - loadView

/**
 优惠券信息显示的卡片背景view
 
 @return view
 */
- (UIView *)cellBackView{
    if (!_cellBackView) {
        _cellBackView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, self.height - 10)];
        _cellBackView.backgroundColor = CPNCommonWhiteColor;
        _cellBackView.layer.cornerRadius = 5.0;
        _cellBackView.clipsToBounds = YES;
        [self addSubview:_cellBackView];
    }
    return _cellBackView;
}


/**
 优惠券图片显示的view
 
 @return imageView
 */
- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.cellBackView.height - 20, self.cellBackView.height - 20)];
        _itemImageView.image = [UIImage imageNamed:@"优惠券默认icon"];
        _itemImageView.backgroundColor = [UIColor clearColor];
        [self.cellBackView addSubview:_itemImageView];
    }
    return _itemImageView;
}


/**
 优惠券名称显示的label
 
 @return label
 */
- (UILabel *)itemNameLabel{
    if (!_itemNameLabel) {
        _itemNameLabel = [CPNCommonLabel commonLabelWithTitle:@"优惠券名称"
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
        _itemNameLabel.numberOfLines = 2;
        _itemNameLabel.text = nil;
        _itemNameLabel.top = self.itemImageView.top;
        [self.cellBackView addSubview:_itemNameLabel];
    }
    return _itemNameLabel;
}



/**
 优惠券可用商户地址显示的label

 @return label
 */
- (UILabel *)itemAddressLabel{
    if (!_itemAddressLabel) {
        _itemAddressLabel = [CPNCommonLabel commonLabelWithTitle:@"酒店位于朝阳区大望路"
                                                        textFont:CPNCommonFontTwelveSize
                                                       textColor:CPNCommonLightGrayColor];
        _itemAddressLabel.numberOfLines = 1;
        _itemAddressLabel.text = nil;
        [self.cellBackView addSubview:_itemAddressLabel];
    }
    return _itemAddressLabel;
}


/**
 领取优惠券按钮

 @return button
 */
- (UIButton *)itemGetButton{
    if (!_itemGetButton) {
        _itemGetButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _itemGetButton.backgroundColor = CPNCommonOrangeColor;
        _itemGetButton.width = 75;
        _itemGetButton.height = self.cellBackView.height;
        [_itemGetButton setTitle:@"立即领取" forState:UIControlStateNormal];
        [_itemGetButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_itemGetButton addTarget:self action:@selector(clickGetCouponAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cellBackView addSubview:_itemGetButton];
    }
    return _itemGetButton;
}


#pragma mark - baseFunction

/**
 刷新坐标
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellBackView.width = self.width - self.cellBackView.left * 2;
    self.cellBackView.height = self.height - 10;

    self.itemImageView.width =
    self.itemImageView.height = self.cellBackView.height - self.itemImageView.top * 2;
    
    self.itemGetButton.height = self.cellBackView.height;
    self.itemGetButton.right = self.cellBackView.width;
    
    self.itemNameLabel.left = self.itemImageView.right + 10;
    self.itemNameLabel.width = self.itemGetButton.left - 10 - self.itemNameLabel.left;
    [self.itemNameLabel sizeToFit];
    
    self.itemAddressLabel.left = self.itemNameLabel.left;
    self.itemAddressLabel.bottom = self.itemImageView.bottom;
    self.itemAddressLabel.width = self.itemGetButton.left - 10 - self.itemAddressLabel.left;
}


/**
 设置优惠券数据model

 @param itemModel 优惠券model
 */
- (void)setItemModel:(CPNGetCouponitemModel *)itemModel{
    _itemModel = itemModel;
    self.itemNameLabel.text = itemModel.name;
    self.itemAddressLabel.text = itemModel.shopAddr;
    if (!itemModel.isCanAccquire) {
        self.itemGetButton.backgroundColor = CPNCommonLightGrayColor;
        self.itemGetButton.enabled = NO;
    }else{
        self.itemGetButton.backgroundColor = CPNCommonOrangeColor;
        self.itemGetButton.enabled = YES;
    }
}



/**
 返回cell行高

 @return 行高
 */
+ (CGFloat)cellHeight{
    return 100;
}


#pragma mark - buttonAction

- (void)clickGetCouponAction{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!delegate.loginUserModel) {
        [SVProgressHUD showInfoWithStatus:@"需要登录后才能领券"];
        return;
    }
    [[CPNHTTPClient instanceClient] requestAccquireCouponWithCounponId:self.itemModel.id
                                                         completeBlock:^(CPNResponse *response, CPNError *error) {
                                                             if (error) {
                                                                 [self requestConnectServerErrorHubTipWithError:error];
                                                             }else{
                                                                 self.itemModel.isCanAccquire = NO;
                                                                 [self setItemModel:_itemModel];
                                                                 //TODO:领取后显示优惠码
                                                                 CPNAlertView *alertView = [[CPNAlertView alloc] initWithTitle:@"恭喜您领取成功"
                                                                                                                       message:@"优惠码是123456"
                                                                                                                  confirmTitle:@"查看我的优惠券"];
                                                                 
                                                                 __weak typeof(alertView) weakAlertView = alertView;
                                                                 alertView.confirmButtonAction = ^{
                                                                     CPNCouponListManagerViewController *couponList = [[CPNCouponListManagerViewController alloc] init];
                                                                     couponList.hidesBottomBarWhenPushed = YES;
                                                                     [self.navigationController pushViewController:couponList animated:YES];
                                                                     [weakAlertView dismiss];
                                                                 };
                                                                 [alertView show];
                                                             }
                                                         }];
    
}

@end
