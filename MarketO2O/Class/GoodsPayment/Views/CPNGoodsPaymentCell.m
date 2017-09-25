//
//  CPNGoodsPaymentCell.m
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNGoodsPaymentCell.h"
#import "HJCAjustNumButton.h"
#import "CPNShopingCartManager.h"
#import "BEMCheckBox.h"

@interface CPNGoodsPaymentCell ()

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
 商品描述文案显示的label
 */
@property (nonatomic, strong) UILabel                       *itemDescriptionLabel;

///**
// 商品积分信息显示label
// */
//@property (nonatomic, strong) UILabel                       *itemPointsLabel;

@property (nonatomic, strong)UILabel                        *itemCount;
/**
 兑换按钮
 */
//@property (nonatomic, strong) HJCAjustNumButton              *numberButton;

//@property (nonatomic, strong) BEMCheckBox                   *checkBox;

@end

@implementation CPNGoodsPaymentCell

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
 商品信息显示的卡片背景view
 
 @return view
 */
- (UIView *)cellBackView{
    if (!_cellBackView) {
        _cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _cellBackView.backgroundColor = CPNCommonWhiteColor;
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
 商品描述文案显示的label
 
 @return label
 */
- (UILabel *)itemDescriptionLabel{
    if (!_itemDescriptionLabel) {
        _itemDescriptionLabel = [CPNCommonLabel commonLabelWithTitle:@"商品描述"
                                                            textFont:CPNCommonFontThirteenSize
                                                           textColor:CPNCommonDarkGrayColor];
        _itemDescriptionLabel.numberOfLines = 2;
        _itemDescriptionLabel.text = nil;
        _itemDescriptionLabel.top = self.itemNameLabel.bottom + 5;
        [self.cellBackView addSubview:_itemDescriptionLabel];
    }
    return _itemDescriptionLabel;
}


///**
// 商品积分信息显示的label
// 
// @return label
// */
//- (UILabel *)itemPointsLabel{
//    if (!_itemPointsLabel) {
//        _itemPointsLabel = [CPNCommonLabel commonLabelWithTitle:@"商品积分"
//                                                       textFont:CPNCommonFontTwelveSize
//                                                      textColor:CPNCommonDarkGrayColor];
//        _itemPointsLabel.text = nil;
//        _itemPointsLabel.numberOfLines = 1;
//        [self.cellBackView addSubview:_itemPointsLabel];
//    }
//    return _itemPointsLabel;
//}

/**
 商品数量
 */
- (UILabel *)itemCount{
    if (!_itemCount) {
        _itemCount = [CPNCommonLabel commonLabelWithTitle:@"商品积分"
                                                       textFont:CPNCommonFontTwelveSize
                                                      textColor:CPNCommonDarkGrayColor];
        _itemCount.text = nil;
        _itemCount.numberOfLines = 1;
        [self.cellBackView addSubview:_itemCount];
    }
    return _itemCount;
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
//    self.checkBox.centerY = self.itemImageView.centerY;
    self.itemNameLabel.left = self.itemImageView.right + 10;
    self.itemNameLabel.width = self.cellBackView.width - self.itemNameLabel.left - 10;
    
    self.itemDescriptionLabel.top = self.itemNameLabel.bottom + 5;
    self.itemDescriptionLabel.left = self.itemNameLabel.left;
    self.itemDescriptionLabel.width = self.itemNameLabel.width;
    [self.itemDescriptionLabel sizeToFit];
    self.itemDescriptionLabel.width = self.itemNameLabel.width;
    
//    self.numberButton.right = self.cellBackView.width - 10;
//    self.numberButton.bottom = self.itemImageView.bottom;
    
    self.itemCount.right = self.cellBackView.right - 10;
    self.itemCount.bottom = self.itemImageView.bottom;
    [self.itemDescriptionLabel sizeToFit];
}



/**
 设置数据model
 
 @param itemModel 商品model
 */
- (void)setItemModel:(CPNShopingCartItemModel *)itemModel{
    _itemModel = itemModel;
    self.itemNameLabel.text = itemModel.name;
    self.itemDescriptionLabel.text = itemModel.desc;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
    [self.itemCount setText:[NSString stringWithFormat:@"x%ld", itemModel.count]];
    [self.itemDescriptionLabel sizeToFit];
}


/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight{
    return 120;
}

@end
