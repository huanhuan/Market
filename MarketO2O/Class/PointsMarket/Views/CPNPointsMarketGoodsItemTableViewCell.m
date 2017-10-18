//
//  CPNPointsMarketGoodsItemTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNPointsMarketGoodsItemTableViewCell.h"
#import "CPNHomePageProductItemModel.h"
#import "UIImageView+WebCache.h"
#import "CPNExchangeProductAlertView.h"
#import "CPNOrderListViewController.h"
#import "CPNShopingCartItemModel.h"
#import "CPNGoodsPaymentManager.h"

@interface CPNPointsMarketGoodsItemTableViewCell ()

/**
 商品信息显示的背景卡片
 */
@property (nonatomic, strong) UIView                        *cellBackView;

/**
 商品图片展示imageView
 */
@property (nonatomic, strong) UIImageView                   *itemImageView;

/**
 商品名称展示label
 */
@property (nonatomic, strong) UILabel                       *itemNameLabel;

/**
 商品积分信息显示label
 */
@property (nonatomic, strong) UILabel                       *itemPointsLabel;

/**
 兑换按钮
 */
@property (nonatomic, strong) UIButton                      *buyButton;

/**
 立即兑换弹框
 */
@property (nonatomic, strong) CPNExchangeProductAlertView   *alertView;

@end

@implementation CPNPointsMarketGoodsItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - loadView

/**
 商品信息显示的卡片背景view
 
 @return view
 */
- (UIView *)cellBackView{
    if (!_cellBackView) {
        _cellBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height - 10)];
        _cellBackView.backgroundColor = CPNCommonWhiteColor;
        _cellBackView.layer.cornerRadius = 5.0;
        [self addSubview:_cellBackView];
    }
    return _cellBackView;
}


/**
 商品图片显示的view
 
 @return imageView
 */
- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.cellBackView.height - 20, self.cellBackView.height - 20)];
        _itemImageView.backgroundColor = [UIColor clearColor];
        [self.cellBackView addSubview:_itemImageView];
    }
    return _itemImageView;
}


/**
 商品名称显示的label
 
 @return label
 */
- (UILabel *)itemNameLabel{
    if (!_itemNameLabel) {
        _itemNameLabel = [CPNCommonLabel commonLabelWithTitle:@"商品名称"
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
        _itemNameLabel.numberOfLines = 1;
        _itemNameLabel.text = nil;
        _itemNameLabel.top = self.itemImageView.top;
        [self.cellBackView addSubview:_itemNameLabel];
    }
    return _itemNameLabel;
}


/**
 商品积分信息显示的label
 
 @return label
 */
- (UILabel *)itemPointsLabel{
    if (!_itemPointsLabel) {
        _itemPointsLabel = [CPNCommonLabel commonLabelWithTitle:@"商品积分"
                                                       textFont:CPNCommonFontTwelveSize
                                                      textColor:CPNCommonDarkGrayColor];
        _itemPointsLabel.text = nil;
        _itemPointsLabel.numberOfLines = 1;
        [self.cellBackView addSubview:_itemPointsLabel];
    }
    return _itemPointsLabel;
}


/**
 立即兑换按钮
 
 @return button
 */
- (UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _buyButton.backgroundColor = CPNCommonOrangeColor;
        _buyButton.layer.cornerRadius = 3.0;
        _buyButton.width = 80;
        _buyButton.height = 30;
        [_buyButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_buyButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        _buyButton.titleLabel.font = CPNCommonFontThirteenSize;
        [_buyButton addTarget:self action:@selector(clickBuyNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cellBackView addSubview:_buyButton];
    }
    return _buyButton;
}



#pragma mark - baseFucntion

/**
 重新刷新子view的坐标
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.cellBackView.width = self.width - self.cellBackView.left * 2;
    self.cellBackView.height = self.height - 10;
    
    self.itemImageView.width =
    self.itemImageView.height = self.cellBackView.height - self.itemImageView.top * 2;
    
    self.itemNameLabel.left = self.itemImageView.right + 10;
    self.itemNameLabel.width = self.cellBackView.width - self.itemNameLabel.left - 10;
    
    self.itemPointsLabel.left = self.itemNameLabel.left;
    self.itemPointsLabel.top = self.itemNameLabel.bottom + 5;
    self.itemPointsLabel.width = self.itemNameLabel.width;
    
    self.buyButton.left = self.itemNameLabel.left;
    self.buyButton.bottom = self.itemImageView.bottom;
}



/**
 设置数据model
 
 @param itemModel 商品model
 */
- (void)setItemModel:(CPNHomePageProductItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.itemNameLabel.text = itemModel.name;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
    
    NSString *pointsString = [NSString stringWithFormat:@"价值%ld积分",itemModel.points];
    self.itemPointsLabel.text = pointsString;
}



/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight{
    return 110;
}



#pragma mark - buttonAction

/**
 点击立即兑换按钮事件
 */
- (void)clickBuyNowButtonAction{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!delegate.loginUserModel) {
        [SVProgressHUD showInfoWithStatus:@"需要登录才能兑换商品"];
        return;
    }
    if (CPN_SELF_MODEL.points < self.itemModel.points) {
        [SVProgressHUD showInfoWithStatus:@"积分不够"];
        return;
    }
    CPNShopingCartItemModel *model = [CPNShopingCartItemModel new];
    model.count = 1;
    model.id = self.itemModel.id;
    model.name = self.itemModel.name;
    model.desc = self.itemModel.desc;
    model.imageUrl = self.itemModel.imageUrl;
    model.points = self.itemModel.points;
    
    [[CPNGoodsPaymentManager sharedCPNGoodsPaymentManager] gotoGoodsPaymentVC:@[model]];
//    CPNExchangeProductAlertView *alertView = [[CPNExchangeProductAlertView alloc] initWithTitle:nil
//                                                                                        message:nil
//                                                                                   confirmTitle:@"立即兑换"];
//    __weak typeof(alertView) weakAlertView = alertView;
//    alertView.confirmButtonAction = ^{
//        if (!weakAlertView.nameText) {
//            return ;
//        }
//
//        if (!weakAlertView.phoneText) {
//            return;
//        }
//
//        if (!weakAlertView.addressText) {
//            return;
//        }
//        [self requestBuyNowProductWithName:weakAlertView.nameText
//                                 phoneText:weakAlertView.phoneText
//                               addressText:weakAlertView.addressText];
//        [weakAlertView dismiss];
//        self.alertView = nil;
//    };
//
//    alertView.closeButtonAction = ^{
//        [weakAlertView dismiss];
//        self.alertView = nil;
//    };
//    [alertView show];
//    self.alertView = alertView;
}


#pragma mark - networkRequest

/**
 立即兑换请求
 
 @param nameText 收货人姓名
 @param phoneText 收货人手机号
 @param addressText 收货地址
 */
- (void)requestBuyNowProductWithName:(NSString *)nameText
                           phoneText:(NSString *)phoneText
                         addressText:(NSString *)addressText{
    [[CPNHTTPClient instanceClient] requestBuyProductWithProductId:self.itemModel.id
                                                              name:nameText
                                                             phone:phoneText
                                                           address:addressText
                                                     completeBlock:^(CPNResponse *response, CPNError *error) {
                                                         if (error) {
                                                             [self requestConnectServerErrorHubTipWithError:error];
                                                         }else{
                                                             CPN_SELF_MODEL.points -= self.itemModel.points;

                                                             CPNAlertView *alertView = [[CPNAlertView alloc] initWithTitle:@"恭喜您兑换成功"
                                                                                                                   message:@"商家将在3个工作日内发货，请留意快递信息，若有疑问，可拨打客服热线100-000-0000"
                                                                                                              confirmTitle:@"查看我的订单"];
                                                             __weak typeof(alertView) weakAlertView = alertView;
                                                             alertView.confirmButtonAction = ^{
                                                                 CPNOrderListViewController *orderList = [[CPNOrderListViewController alloc] init];
                                                                 orderList.hidesBottomBarWhenPushed = YES;
                                                                 [self.navigationController pushViewController:orderList animated:YES];
                                                                 [weakAlertView dismiss];
                                                             };
                                                             [alertView show];
                                                         }
                                                     }];
}


#pragma mark - keyboardMsgAction

/**
 键盘弹出逻辑
 
 @param note 键盘通知
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGRect keyboardRect =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (keyboardRect.origin.y == MAIN_SCREEN_HEIGHT) {
        if (self.alertView) {
            [UIView animateWithDuration:animationDuration animations:^{
                self.alertView.centerY = [CPNPopBackView sharedInstance].height/2;
            }];
        }
    }else{
        if (self.alertView) {
            CGFloat offsetY = keyboardRect.origin.y - self.alertView.height;
            if (offsetY <= 0) {
                offsetY = 0;
            }
            [UIView animateWithDuration:animationDuration animations:^{
                self.alertView.top = offsetY;
            }];
        }
    }
}


@end
