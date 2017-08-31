//
//  CPNLoginButtonView.m
//  FastRecord
//
//  Created by CPN on 16/6/23.
//  Copyright © 2016年 . All rights reserved.
//

#import "CPNLabelAndTextFieldView.h"
#import "CPNBaseViewController.h"
#import "CPNCommonLabel.h"


static CGFloat WidthWithLoginTipLabelLeft = 15;

@interface CPNLabelAndTextFieldView ()<UITextFieldDelegate>


@end

@implementation CPNLabelAndTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
                      tipText:(NSString *)tipText
                 tipTextColor:(UIColor *)tipColor
                      tipFont:(UIFont *)tipFont
           textFieldTextColor:(UIColor *)textColor
            textFieldTextFont:(UIFont *)textFont
           textFieldPlaceHold:(NSString *)placeHold{
    self = [super initWithFrame:frame];
    if (self) {
        _tipLabel = [CPNCommonLabel commonLabelWithTitle:tipText
                                                textFont:tipFont
                                               textColor:tipColor];
        _tipLabel.left = WidthWithLoginTipLabelLeft;
        _tipLabel.centerY = self.height/2;
        [self addSubview:_tipLabel];
        
        _textField = [self textFieldWithTextColor:textColor
                                             font:textFont
                                        placehold:placeHold];
        _textField.left = _tipLabel.right + WidthWithLoginTipLabelLeft;
        _textField.width = self.width - 10 - _textField.left;
        [_textField addTarget:self action:@selector(clickEditChangeFieldText:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
        
        _separateLine = [self separateLineWithColor:CPNCommonLineLayerColorColor
                                             frame:CGRectMake(_tipLabel.left
                                                              , self.height - 0.5
                                                              , _textField.right - _tipLabel.left
                                                              , 0.5)];
        [self addSubview:_separateLine];
    }
    return self;
}



- (void)removeSeparateLine{
    [_separateLine removeFromSuperview];
}


- (void)setSeparateLineHidden:(BOOL)hidden{
    _separateLine.hidden = hidden;
}


- (CPNTextField *)textFieldWithTextColor:(UIColor *)textColor
                                    font:(UIFont *)textFont
                               placehold:(NSString *)placeHold{
    CPNTextField *textField            = [[CPNTextField alloc] init];
    textField.height                   = self.height;
    textField.textColor                = textColor;
    textField.font                     = textFont;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.backgroundColor          = [UIColor clearColor];
    textField.delegate                 = self;
    textField.returnKeyType            = UIReturnKeyDone;
    textField.placeholder              = placeHold;
    [textField setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
    
    return textField;
}


- (UIView *)separateLineWithColor:(UIColor *)color
                            frame:(CGRect)frame{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}


- (void)clickEditChangeFieldText:(CPNTextField *)textField{
    if (textField.limitMaxLenth != NSIntegerMax) {
        NSString *toBeString = textField.text;
        NSInteger maxLenth = textField.limitMaxLenth;
        NSString *maxLenthTipString = [NSString stringWithFormat:@"最多%@个字",@(maxLenth)];
        NSString *primaryLanguage = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
        if ([primaryLanguage isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > maxLenth) {
                    textField.text = [toBeString substringToIndex:maxLenth];
                    [SVProgressHUD showInfoWithStatus:maxLenthTipString];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
            }
        }
        else{//其它语言
            if (toBeString.length > maxLenth) {
                textField.text = [toBeString substringToIndex:maxLenth];
                [SVProgressHUD showInfoWithStatus:maxLenthTipString];
            }
        }
    }
    
    
    
    if (self.textFieldEditChangeAction) {
        self.textFieldEditChangeAction();
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if (textField.keyboardType == UIKeyboardTypeDecimalPad) {
        if ([textField.text isEqualToString:@"0"]) {
            if ([string isEqualToString:@"0"]) {
                return NO;
            }
        }
        
        if ([string isEqualToString:@"."]){
            NSString *pointStr = @".";
            NSRange pointRange = [textField.text rangeOfString:pointStr];
            if (pointRange.location != NSNotFound) {
                return NO;
            }
        }
        
        NSString *pointStr = @".";
        NSRange pointRange = [textField.text rangeOfString:pointStr];
        if (pointRange.location != NSNotFound) {
            if ([CPNInputValidUtil isBlinkString:string]) {
                return YES;
            }else{
                if (range.location <= pointRange.location) {
                    return YES;
                }
                CPNTextField *field = (CPNTextField *)textField;
                if (textField.text.length - pointRange.location - pointRange.length >= field.validPointCount) {
                    return NO;
                }
            }
        }
    }
    return YES;
}



@end
