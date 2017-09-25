//
//  CPNGoodsPayMentBottonView.m
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNGoodsPayMentBottonView.h"

@interface CPNGoodsPayMentBottonView()

@property (nonatomic, strong)UILabel *totalPointTitleLabel;
@property (nonatomic, strong)UILabel *totalPointLabel;

@property (nonatomic, strong)UILabel *goodsNeedPointTitleLabel;
@property (nonatomic, strong)UILabel *goodsNeedPointLabel;

@property (nonatomic, strong)UILabel *needPayMoneyTitleLabel;
@property (nonatomic, strong)UILabel *needPayMoneyCountLabel;

@property (nonatomic, strong)UIButton *confirmButton;

@end

@implementation CPNGoodsPayMentBottonView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.totalPointTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(@10);
        }];
        
        [self.totalPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(@10);
        }];
        
        [self.goodsNeedPointTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.totalPointTitleLabel.mas_bottom).offset(10);
        }];
        
        [self.goodsNeedPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.totalPointLabel.mas_bottom).offset(10);
        }];
        
        [self.needPayMoneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.goodsNeedPointTitleLabel.mas_bottom).offset(10);
//            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [self.needPayMoneyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.goodsNeedPointLabel.mas_bottom).offset(10);
//            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.needPayMoneyCountLabel.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [self setBackgroundColor:CPNCommonWhiteColor];
    }
    return self;
}

- (void)update:(NSInteger)payPoints remainPoints:(NSInteger)retainPoints needPayMoney:(float)needPayMoney
{
    [self.totalPointLabel setText:[NSString stringWithFormat:@"%ld", payPoints]];
    [self.goodsNeedPointLabel setText:[NSString stringWithFormat:@"%ld", retainPoints]];
    [self.needPayMoneyCountLabel setText:[NSString stringWithFormat:@"¥ %.2f", needPayMoney]];
    if (needPayMoney > 0) {
        [self.confirmButton setTitle:@"微信支付" forState:UIControlStateNormal];
        [self.confirmButton setBackgroundColor:CPNCommonGreenColor];
    }
}

- (UILabel *)totalPointTitleLabel
{
    if (!_totalPointTitleLabel) {
        _totalPointTitleLabel = [CPNCommonLabel commonLabelWithTitle:@"支付积分："
                                                      textFont:CPNCommonFontFifteenSize
                                                     textColor:CPNCommonBlackColor];
        _totalPointTitleLabel.numberOfLines = 1;
        [self addSubview:_totalPointTitleLabel];
    }
    return _totalPointTitleLabel;
}

- (UILabel *)goodsNeedPointTitleLabel
{
    if (!_goodsNeedPointTitleLabel) {
        _goodsNeedPointTitleLabel = [CPNCommonLabel commonLabelWithTitle:@"剩余积分："
                                                       textFont:CPNCommonFontFifteenSize
                                                      textColor:CPNCommonBlackColor];
        _goodsNeedPointTitleLabel.numberOfLines = 1;
        [self addSubview:_goodsNeedPointTitleLabel];
    }
    return _goodsNeedPointTitleLabel;
}

- (UILabel *)needPayMoneyTitleLabel
{
    if (!_needPayMoneyTitleLabel) {
        _needPayMoneyTitleLabel = [CPNCommonLabel commonLabelWithTitle:@"微信支付："
                                                           textFont:CPNCommonFontFifteenSize
                                                          textColor:CPNCommonBlackColor];
        _needPayMoneyTitleLabel.numberOfLines = 1;
        [self addSubview:_needPayMoneyTitleLabel];
    }
    return _needPayMoneyTitleLabel;
}

- (UILabel *)totalPointLabel
{
    if (!_totalPointLabel) {
        _totalPointLabel = [CPNCommonLabel commonLabelWithTitle:@"0.0"
                                                       textFont:CPNCommonFontFifteenSize
                                                      textColor:CPNCommonLightRedColor];
        _totalPointLabel.numberOfLines = 1;
        [self addSubview:_totalPointLabel];
    }
    return _totalPointLabel;
}

- (UILabel *)goodsNeedPointLabel
{
    if (!_goodsNeedPointLabel) {
        _goodsNeedPointLabel = [CPNCommonLabel commonLabelWithTitle:@"0.0"
                                                       textFont:CPNCommonFontFifteenSize
                                                      textColor:CPNCommonLightRedColor];
        _goodsNeedPointLabel.numberOfLines = 1;
        [self addSubview:_goodsNeedPointLabel];
    }
    return _goodsNeedPointLabel;
}

- (UILabel *)needPayMoneyCountLabel
{
    if (!_needPayMoneyCountLabel) {
        _needPayMoneyCountLabel = [CPNCommonLabel commonLabelWithTitle:@"¥ 0.0"
                                                       textFont:CPNCommonFontFifteenSize
                                                      textColor:CPNCommonLightRedColor];
        _needPayMoneyCountLabel.numberOfLines = 1;
        [self addSubview:_needPayMoneyCountLabel];
    }
    return _needPayMoneyCountLabel;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmButton setBackgroundColor:CPNCommonLightRedColor];
        [_confirmButton.titleLabel setFont:CPNCommonFontFifteenSize];
        [_confirmButton setTitle:@"马上下单" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.cornerRadius = 10;
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
@end
