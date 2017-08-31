//
//  CPNProductStarView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNProductStarView.h"
#import "CPNHomePageProductItemModel.h"

@interface CPNProductStarView ()

@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UIView    *starView;
@property (nonatomic, strong) UILabel   *starLabel;

@end

@implementation CPNProductStarView

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
        _tipLabel = [CPNCommonLabel commonLabelWithTitle:@"评分"
                                                textFont:CPNCommonFontFifteenSize
                                               textColor:CPNCommonMiddleBlackColor];
        _tipLabel.numberOfLines = 1;
        _tipLabel.left = 15;
        _tipLabel.top = 10;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}


/**
 商品评分五角星显示

 @return view
 */
- (UIView *)starView{
    if (!_starView) {
        _starView = [[UIView alloc] initWithFrame:CGRectMake(self.tipLabel.left, self.tipLabel.bottom + 10, 110, 25)];
        _starView.backgroundColor = [UIColor clearColor];
        [self addSubview:_starView];
    }
    return _starView;
}


/**
 商品具体评分显示

 @return label
 */
- (UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [CPNCommonLabel commonLabelWithTitle:@"5分"
                                                 textFont:CPNCommonFontThirteenSize
                                                textColor:CPNCommonDarkOrangeColor];
        _starLabel.text = nil;
        _starLabel.numberOfLines = 1;
        _starLabel.left = self.starView.right + 15;
        _starLabel.centerY = self.starView.centerY;
        [self addSubview:_starLabel];
    }
    return _starLabel;
}


#pragma mark - baseFunction

/**
 设置物料model，刷新数据

 @param productModel 物料model
 */
- (void)setProductModel:(CPNHomePageProductItemModel *)productModel{
    _productModel = productModel;
    [self.starView removeAllSubviews];
    CGFloat left = 0;
    CGFloat productStar = [productModel.star floatValue];
    NSInteger fullStarCount = floor(productStar);
    for (NSInteger index = 0; index < 5; index++) {
        NSString *imageName = @"五角星icon-未选中";
        if (index < fullStarCount) {
            imageName = @"五角星icon-选中";
        }else{
            if (index < productStar && index + 1 > productStar) {
                imageName = @"五角星icon-半选中";
            }
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.size = CGSizeMake(15, 15);
        imageView.left = left;
        imageView.centerY = self.starView.height/2;
        [self.starView addSubview:imageView];
        left += (imageView.width + 10);
    }
    self.tipLabel.hidden = NO;
    self.starLabel.text = [NSString stringWithFormat:@"%@分",productModel.star];
    self.starLabel.width = self.width - self.starLabel.left - 10;
    [self.starLabel sizeToFit];
}


/**
 返回view的高度

 @return 高度
 */
+ (CGFloat)productStarViewHeight{
    return 70;
}

@end
