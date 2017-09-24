//
//  CPNShopingCartItemCell.m
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNShopingCartItemCell.h"
#import "HJCAjustNumButton.h"
#import "CPNShopingCartManager.h"
#import "BEMCheckBox.h"

@interface CPNShopingCartItemCell ()

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

/**
 商品积分信息显示label
 */
@property (nonatomic, strong) UILabel                       *itemPointsLabel;

/**
 兑换按钮
 */
@property (nonatomic, strong) HJCAjustNumButton              *numberButton;

@property (nonatomic, strong) BEMCheckBox                   *checkBox;

@end

@implementation CPNShopingCartItemCell

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
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 10, self.cellBackView.height - 20, self.cellBackView.height - 20)];
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
- (HJCAjustNumButton *)numberButton{
    if (!_numberButton) {
        HJCAjustNumButton *btn = [[HJCAjustNumButton alloc] init];
        
        // 设置Frame，如不设置则默认为(0, 0, 110, 30)
        btn.frame = CGRectMake(100, 200, 80, 25);
        
        // 内容更改的block回调
        btn.callBack = ^(NSString *currentNum){
            NSLog(@"%@", currentNum);
        };
        _numberButton = btn;
         [self.cellBackView addSubview:_numberButton];
        WeakSelf
        _numberButton.callBack = ^(NSString *currentNumber){
            NSInteger number = [currentNumber integerValue];
            weakSelf.itemModel.count = number;
            [[CPNShopingCartManager sharedCPNShopingCartManager] updateShopingCart:weakSelf.itemModel];
            if ([weakSelf.delegate respondsToSelector:@selector(updateItemModelCount:)]) {
                [weakSelf.delegate updateItemModelCount:weakSelf.itemModel];
            }
        };
    }
    return _numberButton;
}

- (BEMCheckBox *)checkBox
{
    if (!_checkBox) {
        _checkBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        _checkBox.tintColor = CPNCommonLightGrayColor;
        _checkBox.onTintColor =
        _checkBox.onCheckColor = CPNCommonRedColor;
        _checkBox.delegate = (id<BEMCheckBoxDelegate>)self;
        [self addSubview:_checkBox];
    }
    return _checkBox;
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
    self.checkBox.centerY = self.itemImageView.centerY;
    self.itemNameLabel.left = self.itemImageView.right + 10;
    self.itemNameLabel.width = self.cellBackView.width - self.itemNameLabel.left - 10;
    
    self.itemDescriptionLabel.top = self.itemNameLabel.bottom + 5;
    self.itemDescriptionLabel.left = self.itemNameLabel.left;
    self.itemDescriptionLabel.width = self.itemNameLabel.width;
    [self.itemDescriptionLabel sizeToFit];
    self.itemDescriptionLabel.width = self.itemNameLabel.width;
    
    self.numberButton.right = self.cellBackView.width - 10;
    self.numberButton.bottom = self.itemImageView.bottom;
    
    self.itemPointsLabel.left = self.itemNameLabel.left;
    self.itemPointsLabel.bottom = self.numberButton.bottom;
    self.itemPointsLabel.width = self.numberButton.left - self.itemPointsLabel.left - 10;
    
    [self.checkBox reload];
}



/**
 设置数据model
 
 @param itemModel 商品model
 */
- (void)setItemModel:(CPNShopingCartItemModel *)itemModel{
    _itemModel = itemModel;

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.checkBox.on != itemModel.selected) {
            [self.checkBox setOn:itemModel.selected animated:YES];
        }
    });
    //[self.checkBox reload];
    self.itemNameLabel.text = itemModel.name;
    self.itemDescriptionLabel.text = itemModel.desc;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] placeholderImage:[UIImage imageNamed:@"图片默认图"]];
    self.numberButton.currentNum = [NSString stringWithFormat:@"%ld", itemModel.count];
    NSString *pointsString = [NSString stringWithFormat:@"价值%ld积分",itemModel.points];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:pointsString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonDarkGrayColor range:NSMakeRange(0, pointsString.length)];
    NSRange pointRange = [pointsString rangeOfString:[NSString stringWithFormat:@"%ld",itemModel.points]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:CPNCommonRedColor range:pointRange];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontTwelveSize range:NSMakeRange(0, pointsString.length)];
    [attributeString addAttribute:NSFontAttributeName value:CPNCommonFontFourteenSize range:pointRange];
    self.itemPointsLabel.attributedText = attributeString;
}



/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight{
    return 120;
}

#pragma mark checkBox
/** Sent to the delegate every time the check box gets tapped.
 * @discussion This method gets triggered after the properties are updated (on), but before the animations, if any, are completed.
 * @seealso animationDidStopForCheckBox:
 * @param checkBox The BEMCheckBox instance that has been tapped.
 */
- (void)didTapCheckBox:(BEMCheckBox*)checkBox
{
#warning 修改
    if (checkBox.on) {
        if ([self.delegate respondsToSelector:@selector(selecteItemModel:status:)]) {
            [self.delegate selecteItemModel:self.itemModel status:YES];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(selecteItemModel:status:)]) {
            [self.delegate selecteItemModel:self.itemModel status:NO];
        }
    }
}


/** Sent to the delegate every time the check box finishes being animated.
 * @discussion This method gets triggered after the properties are updated (on), and after the animations are completed. It won't be triggered if no animations are started.
 * @seealso didTapCheckBox:
 * @param checkBox The BEMCheckBox instance that was animated.
 */
- (void)animationDidStopForCheckBox:(BEMCheckBox *)checkBox
{

}


@end
