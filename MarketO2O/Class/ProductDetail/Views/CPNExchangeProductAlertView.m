//
//  CPNExchangeButtonAlertView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/13.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNExchangeProductAlertView.h"
#import "CPNTextField.h"

static CGFloat WidthWithTipLabel = 70;

@interface CPNExchangeProductAlertView ()<UITextViewDelegate>

@property (nonatomic, strong) CPNTextField  *nameTextField;
@property (nonatomic, strong) CPNTextField  *phoneTextField;
@property (nonatomic, strong) UITextView    *addressTextView;
@property (nonatomic, strong) UILabel       *textViewTipLabel;

@end

@implementation CPNExchangeProductAlertView

#pragma mark - loadView

/**
 姓名输入框

 @return textField
 */
- (CPNTextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [self itemViewWithFrame:CGRectMake(0, 20, self.width, 40)
                      tipString:@"姓名："
                       texField:_nameTextField
                  placeHoldText:@"请输入收货人姓名"];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        [_nameTextField layoutIfNeeded];
    }
    return _nameTextField;
}


/**
 手机号输入框

 @return textField
 */
- (CPNTextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [self itemViewWithFrame:self.nameTextField.superview.frame
                      tipString:@"手机号："
                       texField:_phoneTextField
                  placeHoldText:@"请输入收货人手机号"];
        _phoneTextField.superview.top = self.nameTextField.superview.bottom +15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTextField layoutIfNeeded];
    }
    return _phoneTextField;
}


/**
 地址输入框

 @return textView
 */
- (UITextView *)addressTextView{
    if (!_addressTextView) {
        UIView *phoneView = self.phoneTextField.superview;
        _addressTextView = [self itemViewWithFrame:CGRectMake(phoneView.left, phoneView.bottom + 15, phoneView.width, 60)
                      tipString:@"详细地址："
                       textView:_addressTextView
                  placeHoldText:@"请输入详细收货地址"];
        _addressTextView.keyboardType = UIKeyboardTypeDefault;
        _addressTextView.returnKeyType = UIReturnKeyDone;
    }
    return _addressTextView;
}


/**
 地址输入框hint提示

 @return label
 */
- (UILabel *)textViewTipLabel{
    if (!_textViewTipLabel) {
        _textViewTipLabel = [CPNCommonLabel commonLabelWithTitle:@"请输入详细收货地址"
                                                        textFont:CPNCommonFontThirteenSize
                                                       textColor:CPNCommonMaxLightGrayColor];
        _textViewTipLabel.numberOfLines = 1;
        _textViewTipLabel.left = 5;
        _textViewTipLabel.top = 5;
        [self.addressTextView addSubview:_textViewTipLabel];
    }
    return _textViewTipLabel;
}


- (CPNTextField *)itemViewWithFrame:(CGRect)rect
                    tipString:(NSString *)tipString
                     texField:(CPNTextField *)texField
                placeHoldText:(NSString *)placeHoldText{
    UIView *itemView = [[UIView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor clearColor];
    [self.whiteBackView addSubview:itemView];
    
    UILabel *tipLabel = [CPNCommonLabel commonLabelWithTitle:tipString
                                                    textFont:CPNCommonFontThirteenSize
                                                   textColor:CPNCommonMiddleBlackColor];
    tipLabel.numberOfLines = 1;
    tipLabel.width = WidthWithTipLabel;
    tipLabel.centerY = itemView.height/2;
    tipLabel.left = 15;
    [itemView addSubview:tipLabel];
    
    texField = [CPNTextField textFieldWithFrame:CGRectMake(tipLabel.right, 0, itemView.width - tipLabel.right - 10, itemView.height)
                                      textColor:CPNCommonMiddleBlackColor
                                       textFont:CPNCommonFontThirteenSize
                                     placeehold:placeHoldText
                              textFieldDelegate:self
                           textEditChangeAction:nil];
    texField.layer.borderWidth = 1;
    texField.layer.borderColor = CPNCommonLineLayerColorColor.CGColor;
    texField.layer.cornerRadius = 5.0;
    texField.centerY = itemView.height/2;
    [itemView addSubview:texField];
    return texField;
}


- (UITextView *)itemViewWithFrame:(CGRect)rect
                tipString:(NSString *)tipString
                 textView:(UITextView *)textView
            placeHoldText:(NSString *)placeHoldText{
    UIView *itemView = [[UIView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor clearColor];
    [self.whiteBackView addSubview:itemView];
    
    UILabel *tipLabel = [CPNCommonLabel commonLabelWithTitle:tipString
                                                    textFont:CPNCommonFontThirteenSize
                                                   textColor:CPNCommonMiddleBlackColor];
    tipLabel.numberOfLines = 1;
    tipLabel.width = WidthWithTipLabel;
    tipLabel.top = 5;
    tipLabel.left = 15;
    [itemView addSubview:tipLabel];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(tipLabel.right, 0, itemView.width - tipLabel.right - 10, itemView.height)];
    textView.textColor = CPNCommonMiddleBlackColor;
    textView.font = CPNCommonFontThirteenSize;
    textView.delegate = self;
    textView.showsVerticalScrollIndicator = NO;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = CPNCommonLineLayerColorColor.CGColor;
    textView.layer.cornerRadius = 5.0;
    textView.centerY = itemView.height/2;
    [itemView addSubview:textView];
    return textView;
}


#pragma mark - baseFunction

/**
 刷新数据
 */
- (void)refreshAlertViewData{
    self.titleLabel.hidden = YES;
    self.messageLabel.hidden = YES;
    self.nameTextField.superview.top = 20;
    self.phoneTextField.superview.top = self.nameTextField.superview.bottom+ 15;
    self.addressTextView.superview.top = self.phoneTextField.superview.bottom + 15;
    self.buttonTopLine.top = self.addressTextView.superview.bottom + 30;
    self.buttonTopLine.hidden = YES;
    self.confirmButton.backgroundColor = CPNCommonLightRedColor;
    [self.confirmButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
    self.textViewTipLabel.hidden = NO;
    [super refreshButtonFrame];
}


- (void)refreshSubviewsFrame{
    [super refreshSubviewsFrame];
    self.addressTextView.superview.bottom = self.buttonTopLine.top - 30;
    self.addressTextView.superview.width = self.whiteBackView.width;
    self.addressTextView.width = self.addressTextView.superview.width - self.addressTextView.left - 10;
    
    self.phoneTextField.superview.bottom = self.addressTextView.superview.top - 15;
    self.phoneTextField.superview.width = self.addressTextView.superview.width;
    self.phoneTextField.width = self.addressTextView.width;
    
    self.nameTextField.superview.bottom = self.phoneTextField.superview.top - 15;
    self.nameTextField.superview.width = self.phoneTextField.superview.width;
    self.nameTextField.width = self.phoneTextField.width;
}

/**
 收货人

 @return 收货人
 */
- (NSString *)nameText{
    if ([CPNInputValidUtil isBlinkString:self.nameTextField.text]) {
        [SVProgressHUD showInfoWithStatus:@"收货人姓名不能为空"];
        return nil;
    }
    return self.nameTextField.text;
}


/**
 收货手机号

 @return 手机号
 */
- (NSString *)phoneText{
    if ([CPNInputValidUtil isBlinkString:self.phoneTextField.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        return nil;
    }
    if (![CPNInputValidUtil isValidateMobileNumber:self.phoneTextField.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号格式不对，请重新输入"];
        return nil;
    }
    return self.phoneTextField.text;
}

/**
 收货地址

 @return 收货地址
 */
- (NSString *)addressText{
    if ([CPNInputValidUtil isBlinkString:self.addressTextView.text]) {
        [SVProgressHUD showInfoWithStatus:@"收货地址不能为空"];
        return nil;
    }
    return self.addressTextView.text;
}

#pragma mark - textViewDelegate

- (void)textViewDidChangeSelection:(UITextView *)textView{
    self.textViewTipLabel.hidden = textView.hasText;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
        return NO;
    }
    return YES;
}


@end
