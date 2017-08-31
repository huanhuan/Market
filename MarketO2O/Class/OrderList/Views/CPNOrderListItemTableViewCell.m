//
//  CPNOrderListItemTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNOrderListItemTableViewCell.h"
#import "CPNOrderListItemModel.h"
#import "UIImageView+WebCache.h"

@interface CPNOrderListItemTableViewCell ()

/**
 订单卡片背景
 */
@property (nonatomic, strong) UIView        *cellBackView;
/**
 商品图片
 */
@property (nonatomic, strong) UIImageView   *itemImageView;

/**
 商品名称label
 */
@property (nonatomic, strong) UILabel       *itemNameLabel;

/**
 收货人姓名label
 */
@property (nonatomic, strong) UILabel       *userNameLabel;
/**
 收货人手机号显示的label
 */
@property (nonatomic, strong) UILabel       *phoneLabel;

/**
 订单收货地址label
 */
@property (nonatomic, strong) UILabel       *orderAddressLabel;

/**
 优惠券可得积分显示的label
 */
@property (nonatomic, strong) UILabel       *orderPointsLabel;

/**
 订单日期显示的label
 */
@property (nonatomic, strong) UILabel       *orderDateLabel;

@end

@implementation CPNOrderListItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
 收货人姓名显示的label

 @return label
 */
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [CPNCommonLabel commonLabelWithTitle:@"张三"
                                                     textFont:CPNCommonFontThirteenSize
                                                    textColor:CPNCommonLightGrayColor];
        _userNameLabel.text = nil;
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.left = self.itemNameLabel.left;
        _userNameLabel.top = self.itemNameLabel.bottom + 5;
        [self.cellBackView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}


/**
 收货人手机号显示的label

 @return label
 */
- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [CPNCommonLabel commonLabelWithTitle:@"电话：1388888888"
                                                  textFont:CPNCommonFontThirteenSize
                                                 textColor:CPNCommonLightGrayColor];
        _phoneLabel.text = nil;
        _phoneLabel.numberOfLines = 1;
        _phoneLabel.top = self.userNameLabel.top;
        [self.cellBackView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}


/**
 收货地址显示的label

 @return label
 */
- (UILabel *)orderAddressLabel{
    if (!_orderAddressLabel) {
        _orderAddressLabel = [CPNCommonLabel commonLabelWithTitle:@"地址：xxxxx"
                                                         textFont:CPNCommonFontThirteenSize
                                                        textColor:CPNCommonLightGrayColor];
        _orderAddressLabel.text = nil;
        _orderAddressLabel.numberOfLines = 1;
        _orderAddressLabel.left = self.itemNameLabel.left;
        _orderAddressLabel.top = self.userNameLabel.bottom + 5;
        [self.cellBackView addSubview:_orderAddressLabel];
    }
    return _orderAddressLabel;

}



/**
 订单花费的积分信息显示的label

 @return label
 */
- (UILabel *)orderPointsLabel{
    if (!_orderPointsLabel) {
        _orderPointsLabel = [CPNCommonLabel commonLabelWithTitle:@"花费10000积分"
                                                        textFont:CPNCommonFontThirteenSize
                                                       textColor:CPNCommonLightGrayColor];
        _orderPointsLabel.text= nil;
        _orderPointsLabel.numberOfLines = 1;
        _orderPointsLabel.left = self.itemNameLabel.left;
        [self.cellBackView addSubview:_orderPointsLabel];
    }
    return _orderPointsLabel;
}


/**
 订单日期显示的label

 @return label
 */
- (UILabel *)orderDateLabel{
    if (!_orderDateLabel) {
        _orderDateLabel = [CPNCommonLabel commonLabelWithTitle:@"2017.05.20"
                                                      textFont:CPNCommonFontThirteenSize
                                                     textColor:CPNCommonLightGrayColor];
        _orderDateLabel.text = nil;
        _orderDateLabel.numberOfLines = 1;
        [self.cellBackView addSubview:_orderDateLabel];
    }
    return _orderDateLabel;
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
    
    self.itemNameLabel.left = self.itemImageView.right + 10;
    self.itemNameLabel.width = self.cellBackView.width - self.itemNameLabel.left - 10;

    self.userNameLabel.left = self.itemNameLabel.left;
    self.userNameLabel.top = self.itemNameLabel.bottom + 5;
    
    self.phoneLabel.left = self.userNameLabel.right + 20;
    self.phoneLabel.top = self.userNameLabel.top;
    self.phoneLabel.width = self.cellBackView.width - self.phoneLabel.left - 10;
    
    self.orderAddressLabel.left = self.itemNameLabel.left;
    self.orderAddressLabel.top = self.userNameLabel.bottom + 5;
    self.orderAddressLabel.width = self.cellBackView.width - self.orderAddressLabel.left - 10;
    
    self.orderDateLabel.bottom = self.itemImageView.bottom;
    self.orderDateLabel.right = self.cellBackView.width - 10;
    
    self.orderPointsLabel.left = self.itemNameLabel.left;
    self.orderPointsLabel.bottom = self.itemImageView.bottom;
    self.orderPointsLabel.width = self.orderDateLabel.left - self.orderPointsLabel.left - 10;
}


/**
 设置订单数据model

 @param orderModel 订单model
 */
- (void)setOrderModel:(CPNOrderListItemModel *)orderModel{
    _orderModel = orderModel;
    self.itemNameLabel.text = orderModel.goodsName;
    
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:orderModel.goodsImageurl] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
    
    self.userNameLabel.text = orderModel.name;
    self.userNameLabel.width = self.cellBackView.width;
    [self.userNameLabel sizeToFit];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"电话：%@",orderModel.phone];
    
    self.orderAddressLabel.text = [NSString stringWithFormat:@"地址：%@",orderModel.addr];
    
    self.orderDateLabel.text = orderModel.createTime;
    
    NSString *pointsString = [NSString stringWithFormat:@"花费%@积分",orderModel.points];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:pointsString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonLightGrayColor range:NSMakeRange(0, pointsString.length)];
    NSRange pointRange = [pointsString rangeOfString:orderModel.points];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonRedColor range:pointRange];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontTwelveSize range:NSMakeRange(0, pointsString.length)];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontFourteenSize range:pointRange];
    self.orderPointsLabel.attributedText = attributeString;
}


/**
 返回cell高度

 @return cell高度
 */
+ (CGFloat)cellHeight{
    return 120;
}

@end
