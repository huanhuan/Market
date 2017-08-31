//
//  CPNProductDescriptionView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNProductDescriptionView.h"
#import "CPNHomePageProductItemModel.h"

@interface CPNProductDescriptionView ()

@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UILabel   *descLabel;

@end

@implementation CPNProductDescriptionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CPNCommonWhiteColor;
    }
    return self;
}

#pragma mark - loadView

/**
 提示文案显示
 
 @return label
 */
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [CPNCommonLabel commonLabelWithTitle:@"商品详情"
                                                textFont:CPNCommonFontFifteenSize
                                               textColor:CPNCommonMiddleBlackColor];
        _tipLabel.numberOfLines = 1;
        _tipLabel.top = 15;
        _tipLabel.centerX = self.width/2;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}


/**
 商品描述文案显示

 @return label
 */
- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [CPNCommonLabel commonLabelWithTitle:@"商品描述"
                                                 textFont:CPNCommonFontThirteenSize
                                                textColor:CPNCommonMaxDarkGrayColor];
        _descLabel.numberOfLines = 0;
        _descLabel.left = 15;
        _descLabel.top = self.tipLabel.bottom + 15;
        _descLabel.width = self.width - _descLabel.left * 2;
        [self addSubview:_descLabel];
    }
    return _descLabel;
}


#pragma mark - baseFucntion

/**
 设置商品数据model

 @param productModel 商品model
 */
- (void)setProductModel:(CPNHomePageProductItemModel *)productModel{
    _productModel = productModel;
    self.descLabel.text = productModel.desc;
    self.descLabel.width = self.width - self.descLabel.left * 2;
    [self.descLabel sizeToFit];
    
    self.height = self.descLabel.bottom + self.tipLabel.top;
}

@end
