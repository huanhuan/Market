//
//  CPNCouponListItemTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNCouponListItemTableViewCell.h"
#import "CPNCouponListCouponItemModel.h"


@interface CPNCouponListItemTableViewCell ()

/**
 优惠券卡片背景
 */
@property (nonatomic, strong) UIView        *cellBackView;
/**
 优惠券图片
 */
@property (nonatomic, strong) UIImageView   *couponImageView;

/**
 优惠券名称label
 */
@property (nonatomic, strong) UILabel       *couponNameLabel;

/**
 优惠券可用商户地址label
 */
@property (nonatomic, strong) UILabel       *couponAddressLabel;

/**
 优惠码显示的label
 */
@property (nonatomic, strong) UILabel       *couponSnLabel;

/**
 优惠券可得积分显示的label
 */
@property (nonatomic, strong) UILabel       *couponPointsLabel;

/**
 优惠券状态显示的image
 */
@property (nonatomic, strong) UIImageView   *couponStatusImageView;

@end

@implementation CPNCouponListItemTableViewCell

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
- (UIImageView *)couponImageView{
    if (!_couponImageView) {
        _couponImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.cellBackView.height - 20, self.cellBackView.height - 20)];
        _couponImageView.image = [UIImage imageNamed:@"优惠券默认icon"];
        _couponImageView.backgroundColor = [UIColor clearColor];
        [self.cellBackView addSubview:_couponImageView];
    }
    return _couponImageView;
}


/**
 优惠券名称显示的label
 
 @return label
 */
- (UILabel *)couponNameLabel{
    if (!_couponNameLabel) {
        _couponNameLabel = [CPNCommonLabel commonLabelWithTitle:@"优惠券名称"
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
        _couponNameLabel.numberOfLines = 1;
        _couponNameLabel.text = nil;
        _couponNameLabel.top = self.couponImageView.top;
        [self.cellBackView addSubview:_couponNameLabel];
    }
    return _couponNameLabel;
}



/**
 优惠券可用商户地址显示的label
 
 @return label
 */
- (UILabel *)couponAddressLabel{
    if (!_couponAddressLabel) {
        _couponAddressLabel = [CPNCommonLabel commonLabelWithTitle:@"酒店位于朝阳区大望路"
                                                        textFont:CPNCommonFontTwelveSize
                                                       textColor:CPNCommonLightGrayColor];
        _couponAddressLabel.numberOfLines = 1;
        _couponAddressLabel.text = nil;
        [self.cellBackView addSubview:_couponAddressLabel];
    }
    return _couponAddressLabel;
}


/**
 优惠码显示的label

 @return label
 */
- (UILabel *)couponSnLabel{
    if (!_couponSnLabel) {
        _couponSnLabel = [CPNCommonLabel commonLabelWithTitle:@"优惠码：12345678"
                                                     textFont:CPNCommonFontTwelveSize
                                                    textColor:CPNCommonLightGrayColor];
        _couponSnLabel.text = nil;
        _couponSnLabel.numberOfLines = 1;
        _couponSnLabel.left = self.couponNameLabel.left;
        [self.cellBackView addSubview:_couponSnLabel];
    }
    return _couponSnLabel;
}



/**
 优惠券积分相关显示的label

 @return label
 */
- (UILabel *)couponPointsLabel{
    if (!_couponPointsLabel) {
        _couponPointsLabel = [CPNCommonLabel commonLabelWithTitle:@"可获得500积分"
                                                     textFont:CPNCommonFontTwelveSize
                                                    textColor:CPNCommonLightGrayColor];
        _couponPointsLabel.text = nil;
        _couponPointsLabel.numberOfLines = 1;
        [self.cellBackView addSubview:_couponPointsLabel];
    }
    return _couponPointsLabel;
}



/**
 优惠券状态显示的图片

 @return imageView
 */
- (UIImageView *)couponStatusImageView{
    if (!_couponStatusImageView) {
        _couponStatusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        _couponStatusImageView.backgroundColor = [UIColor clearColor];
        //TODO:图片
        _couponStatusImageView.image = [UIImage imageNamed:@""];
        [self.cellBackView addSubview:_couponStatusImageView];
    }
    return _couponStatusImageView;
}


#pragma mark - baseFunction

/**
 刷新坐标
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellBackView.width = self.width - self.cellBackView.left * 2;
    self.cellBackView.height = self.height - 10;
    
    self.couponImageView.width =
    self.couponImageView.height = self.cellBackView.height - self.couponImageView.top * 2;
    
    self.couponNameLabel.left = self.couponImageView.right + 10;
    self.couponNameLabel.width = self.cellBackView.width - 10 - self.couponNameLabel.left;
    
    self.couponAddressLabel.left = self.couponNameLabel.left;
    self.couponAddressLabel.top = self.couponNameLabel.bottom + 5;
    self.couponAddressLabel.width = self.couponNameLabel.width;
    
    self.couponSnLabel.left = self.couponNameLabel.left;
    self.couponSnLabel.bottom = self.couponImageView.bottom;
    
    self.couponPointsLabel.bottom = self.couponImageView.bottom;
    self.couponPointsLabel.left = MAX(self.couponSnLabel.right + 10, self.cellBackView.width - self.couponPointsLabel.width - 10);
    
    self.couponStatusImageView.right = self.cellBackView.width + 10;
    self.couponStatusImageView.top = -10;
}


/**
 社会优惠券数据model

 @param couponModel 优惠券model
 */
- (void)setCouponModel:(CPNCouponListCouponItemModel *)couponModel{
    _couponModel = couponModel;
    self.couponNameLabel.text = couponModel.couponName;
    self.couponAddressLabel.text = couponModel.shopAddr;
    
    self.couponSnLabel.text = [NSString stringWithFormat:@"优惠码：%@",couponModel.code];
    self.couponSnLabel.width = self.cellBackView.width;
    [self.couponSnLabel sizeToFit];
    
    self.couponPointsLabel.text = [NSString stringWithFormat:@"可获得%@积分",couponModel.couponPoints];
    self.couponPointsLabel.width = self.cellBackView.width;
    [self.couponPointsLabel sizeToFit];
}



/**
 设置页面索引

 @param index 索引
 */
- (void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {
        self.couponStatusImageView.image = [UIImage imageNamed:@""];//已领取
    }else{
        self.couponStatusImageView.image = [UIImage imageNamed:@""];//已使用
    }
}


/**
 返回cell行高

 @return 行高
 */
+ (CGFloat)cellHeight{
    return 100;
}

@end
