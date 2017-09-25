//
//  CPNShopingCartBottonView.m
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNShopingCartBottonView.h"
#import "BEMCheckBox.h"

@interface CPNShopingCartBottonView()

@property (nonatomic, strong)BEMCheckBox *checkBox;
@property (nonatomic, strong)UILabel *allSelectLabel;
@property (nonatomic, strong)UILabel *totalMoneyLabel;
@property (nonatomic, strong)UILabel *moneyCountLabel;
@property (nonatomic, strong)UIButton *confirmButton;

@end

@implementation CPNShopingCartBottonView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self);
            make.height.and.width.mas_equalTo(25);
        }];
        
        [self.allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.checkBox.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.top.and.right.equalTo(self);
            make.width.mas_equalTo(90);
        }];
        
        [self.moneyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.confirmButton.mas_left).mas_offset(-5);
            make.top.and.bottom.equalTo(self);
        }];
        
        [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moneyCountLabel.mas_left).mas_offset(-5);
            make.top.and.bottom.equalTo(self);
        }];
        
        
        [self setBackgroundColor:CPNCommonWhiteColor];
    }
    return self;
}

- (BEMCheckBox *)checkBox
{
    if (!_checkBox) {
        _checkBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        _checkBox.on = YES;
        _checkBox.onTintColor =
        _checkBox.onCheckColor = CPNCommonRedColor;
        _checkBox.delegate = (id<BEMCheckBoxDelegate>)self;
        [self addSubview:_checkBox];
    }
    return _checkBox;
}

- (UILabel *)allSelectLabel
{
    if (!_allSelectLabel) {
        _allSelectLabel = [CPNCommonLabel commonLabelWithTitle:@"全选"
                                                       textFont:CPNCommonFontFifteenSize
                                                      textColor:CPNCommonBlackColor];
        _allSelectLabel.numberOfLines = 1;
        [self addSubview:_allSelectLabel];
    }
    return _allSelectLabel;
}

- (UILabel *)totalMoneyLabel
{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [CPNCommonLabel commonLabelWithTitle:@"总计："
                                                      textFont:CPNCommonFontFifteenSize
                                                     textColor:CPNCommonBlackColor];
        _totalMoneyLabel.numberOfLines = 1;
        [self addSubview:_totalMoneyLabel];
    }
    return _totalMoneyLabel;
}

- (UILabel *)moneyCountLabel
{
    if (!_moneyCountLabel) {
        _moneyCountLabel = [CPNCommonLabel commonLabelWithTitle:@"积分 0.0"
                                                      textFont:CPNCommonFontFifteenSize
                                                     textColor:CPNCommonLightRedColor];
        _moneyCountLabel.numberOfLines = 1;
        [self addSubview:_moneyCountLabel];
    }
    return _moneyCountLabel;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmButton setBackgroundColor:CPNCommonMaxLightGrayColor];
        [_confirmButton.titleLabel setFont:CPNCommonFontFifteenSize];
        [_confirmButton setTitle:@"去结算(0件)" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (void)confirmButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(confirmButtonClick)]) {
        [self.delegate confirmButtonClick];
    }
}

- (void)updateSelectNumber:(NSUInteger)number points:(NSUInteger)points hasSelectedAll:(BOOL)selected
{
    if (self.checkBox.on != selected) {
        [self.checkBox setOn:selected animated:YES];
    }
    if (number == 0) {
        [_confirmButton setEnabled:NO];
        [_confirmButton setBackgroundColor:CPNCommonMaxLightGrayColor];

    }else
    {
        [_confirmButton setEnabled:YES];
        [_confirmButton setBackgroundColor:CPNCommonLightRedColor];

    }
    [_moneyCountLabel setText:[NSString stringWithFormat:@"积分 %ld", points]];
    [_confirmButton setTitle:[NSString stringWithFormat:@"去结算(%ld件)", number] forState:UIControlStateNormal];
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
        if ([self.delegate respondsToSelector:@selector(selectedAll:)]) {
            [self.delegate selectedAll:YES];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(selectedAll:)]) {
            [self.delegate selectedAll:NO];
        }
    }
}

@end
