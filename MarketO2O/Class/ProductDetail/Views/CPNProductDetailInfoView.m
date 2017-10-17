//
//  CPNProductDetailInfoView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNProductDetailInfoView.h"
#import "CPNHomePageProductItemModel.h"
#import "CPNOrderListViewController.h"
#import "CPNExchangeProductAlertView.h"

@interface CPNProductDetailInfoView ()

@property (nonatomic, strong) UILabel                       *itemNameLabel;
@property (nonatomic, strong) UILabel                       *itemPointsLabel;
@property (nonatomic, strong) UIButton                      *buyNowButton;
@property (nonatomic, strong) CPNExchangeProductAlertView   *alertView;


@end

@implementation CPNProductDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CPNCommonWhiteColor;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - loadView

/**
 商品名称显示

 @return label
 */
- (UILabel *)itemNameLabel{
    if (!_itemNameLabel) {
        _itemNameLabel = [CPNCommonLabel commonLabelWithTitle:@"商品名称"
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMiddleBlackColor];
        _itemNameLabel.text = nil;
        _itemNameLabel.numberOfLines = 1;
        _itemNameLabel.left = 15;
        _itemNameLabel.top = 10;
        _itemNameLabel.width = self.width;
        [self addSubview:_itemNameLabel];
    }
    return _itemNameLabel;
}


/**
 商品积分信息

 @return label
 */
- (UILabel *)itemPointsLabel{
    if (!_itemPointsLabel) {
        _itemPointsLabel = [CPNCommonLabel commonLabelWithTitle:@"价值1000积分"
                                                       textFont:CPNCommonFontThirteenSize
                                                      textColor:CPNCommonLightGrayColor];
        _itemPointsLabel.text = nil;
        _itemPointsLabel.numberOfLines = 1;
        _itemPointsLabel.left = self.itemNameLabel.left;
        _itemPointsLabel.top = self.itemNameLabel.bottom + 15;
        _itemPointsLabel.width = self.width;
        [self addSubview:_itemPointsLabel];
    }
    return _itemPointsLabel;
}

/**
 立即兑换按钮
 
 @return button
 */
- (UIButton *)buyNowButton{
    if (!_buyNowButton) {
//        _buyNowButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        _buyNowButton.backgroundColor = CPNCommonOrangeColor;
//        _buyNowButton.layer.cornerRadius = 3.0;
//        _buyNowButton.width = 80;
//        _buyNowButton.height = 30;
//        _buyNowButton.bottom = self.itemPointsLabel.bottom;
//        _buyNowButton.right = self.width - 15;
//        [_buyNowButton setTitle:@"立即兑换" forState:UIControlStateNormal];
//        [_buyNowButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
//        _buyNowButton.titleLabel.font = CPNCommonFontThirteenSize;
//        [_buyNowButton addTarget:self action:@selector(clickBuyNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        self.itemPointsLabel.width = _buyNowButton.left - self.itemPointsLabel.left - 10;
//        [self addSubview:_buyNowButton];
    }
    return _buyNowButton;
}


#pragma mark - baseFunction

- (void)setProductModel:(CPNHomePageProductItemModel *)productModel{
    _productModel = productModel;
    self.itemNameLabel.text = productModel.name;
    
    NSString *pointsString = [NSString stringWithFormat:@"价值%ld积分",productModel.points];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:pointsString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonDarkGrayColor range:NSMakeRange(0, pointsString.length)];
    NSRange pointRange = [pointsString rangeOfString:[NSString stringWithFormat:@"%ld", productModel.points]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonRedColor range:pointRange];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontTwelveSize range:NSMakeRange(0, pointsString.length)];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontFourteenSize range:pointRange];
    self.itemPointsLabel.attributedText = attributeString;
    
    self.buyNowButton.hidden = NO;
}

+ (CGFloat)productInfoViewHeight{
    return 70;
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
    if (CPN_SELF_MODEL.points < self.productModel.points) {
        [SVProgressHUD showInfoWithStatus:@"积分不够"];
        return;
    }
    CPNExchangeProductAlertView *alertView = [[CPNExchangeProductAlertView alloc] initWithTitle:nil
                                                                                        message:nil
                                                                                   confirmTitle:@"立即兑换"];
    __weak typeof(alertView) weakAlertView = alertView;
    alertView.confirmButtonAction = ^{
        if (!weakAlertView.nameText) {
            return ;
        }
        
        if (!weakAlertView.phoneText) {
            return;
        }
        
        if (!weakAlertView.addressText) {
            return;
        }
        [self requestBuyNowProductWithName:weakAlertView.nameText
                                 phoneText:weakAlertView.phoneText
                               addressText:weakAlertView.addressText];
        [weakAlertView dismiss];
        self.alertView = nil;
    };
    
    alertView.closeButtonAction = ^{
        [weakAlertView dismiss];
        self.alertView = nil;
    };
    [alertView show];
    self.alertView = alertView;
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
    [[CPNHTTPClient instanceClient] requestBuyProductWithProductId:self.productModel.id
                                                              name:nameText
                                                             phone:phoneText
                                                           address:addressText
                                                     completeBlock:^(CPNResponse *response, CPNError *error) {
                                                         if (error) {
                                                             [self requestConnectServerErrorHubTipWithError:error];
                                                         }else{
                                                             CPN_SELF_MODEL.points -= self.productModel.points;
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
