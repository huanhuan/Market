//
//  CPNProductDescriptionView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNProductDescriptionView.h"
#import "CPNHomePageProductItemModel.h"
#import "ShowImagesFullScreen.h"

@interface CPNProductDescriptionView ()

@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UILabel   *descLabel;

@property (nonatomic, strong)NSMutableArray<UIImageView *> *detailImageViews;

@end

@implementation CPNProductDescriptionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CPNCommonWhiteColor;
        self.detailImageViews = [NSMutableArray new];
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
//    self.descLabel.text = productModel.desc;
//    self.descLabel.width = self.width - self.descLabel.left * 2;
//    [self.descLabel sizeToFit];
    UIView __block *topView = self.tipLabel;
    [productModel.detailImageUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        [self addSubview:tempImageView];
        tempImageView.top = topView.bottom + 15;
        topView = tempImageView;
        [self.detailImageViews addObject:tempImageView];
        tempImageView.tag = idx;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [tempImageView setUserInteractionEnabled:YES];
        [tempImageView addGestureRecognizer:tapGesture];
        [tempImageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
    }];
    self.height = topView.bottom + self.tipLabel.top;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [[ShowImagesFullScreen shareShowImagesFullScreenManager] showImages:self.detailImageViews currentShowImageIndex:tap.view.tag];
}

@end
