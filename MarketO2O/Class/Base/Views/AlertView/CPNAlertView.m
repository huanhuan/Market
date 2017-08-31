//
//  CPNAlertView.m
//  
//
//  Created by CPN on 15/11/30.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNAlertView.h"
#import "CPNTextField.h"

static CGFloat closeButtonViewHeight = 50;

@interface CPNAlertView ()<UITextFieldDelegate,UITextViewDelegate>

/**
 关闭按钮显示的view
 */
@property (nonatomic,strong) UIView    *closeView;

/**
 白色背景
 */
@property (nonatomic,strong) UIView    *whiteBackView;
/**
 *  提示框标题label
 */
@property (nonatomic,strong) UILabel   *titleLabel;
/**
 *  提示框提示信息显示label
 */
@property (nonatomic,strong) UILabel   *messageLabel;
/**
 *  确定按钮
 */
@property (nonatomic,strong) UIButton  *confirmButton;
/**
 *  提示框标题
 */
@property (nonatomic,strong) NSString  *title;
/**
 *  提示信息
 */
@property (nonatomic,strong) NSString  *message;
/**
 *  确定按钮标题
 */
@property (nonatomic,strong) NSString  *confirmTitle;

@end

@implementation CPNAlertView

/**
 *  创建普通弹框样式，包含：title，message，confirmTitle
 *
 *  @param title        提示文案
 *  @param message      说明信息
 *  @param confirmTitle 确认按钮标题
 *
 *  @return CPNAlertView
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       confirmTitle:(NSString *)confirmTitle{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        CGFloat width = MAIN_SCREEN_WIDTH - 50;

        self.width = width;
        self.title = title;
        self.message = message;
        self.confirmTitle = confirmTitle;
        
        if (![self.message hasPrefix:@"<font"]) {
            self.messageLabel.text = self.message;
        }else{
            NSMutableAttributedString *attibuteString = [[NSMutableAttributedString alloc] initWithData:[self.message dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [attibuteString addAttribute:NSFontAttributeName value:self.messageLabel.font range:NSMakeRange(0, attibuteString.length)];
            self.messageLabel.attributedText = attibuteString;
        }
        
        self.messageLabel.hidden = NO;
        [self.messageLabel sizeToFit];
        self.messageLabel.centerX = self.whiteBackView.width/2;
        self.messageLabel.hidden = NO;
        if (!self.message) {
            self.messageLabel.hidden = YES;
        }
        
        if (![self.title hasPrefix:@"<font"]) {
            self.titleLabel.text =  self.title;
        }else{
            NSMutableAttributedString *titleAttibuteString = [[NSMutableAttributedString alloc] initWithData:[self.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [titleAttibuteString addAttribute:NSFontAttributeName value:self.titleLabel.font range:NSMakeRange(0, titleAttibuteString.length)];
            self.titleLabel.attributedText = titleAttibuteString;
        }
        
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = self.whiteBackView.width/2;
        self.titleLabel.hidden = NO;
        self.messageLabel.top = self.titleLabel.top * 2 + self.titleLabel.height;
        if (!self.title) {
            self.titleLabel.hidden = YES;
        }
        
        self.buttonTopLine.top = self.messageLabel.bottom + 20;
        [self refreshButtonFrame];
    }
    return self;
}




#pragma mark - loadView
- (UIView *)closeView{
    if (!_closeView) {
        _closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, closeButtonViewHeight)];
        _closeView.centerX = self.width/2;
        _closeView.backgroundColor = [UIColor clearColor];
        [self addSubview:_closeView];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(0, 0, 40, 40);
        closeButton.right = _closeView.width;
        [closeButton setImage:[UIImage imageNamed:@"白色叉号icon"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(clickCloseAction) forControlEvents:UIControlEventTouchUpInside];
        [_closeView addSubview:closeButton];
        
        UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, closeButton.bottom - 5, 1, 0)];
        separateLine.centerX = closeButton.centerX;
        separateLine.height = _closeView.height - separateLine.top;
        separateLine.backgroundColor = CPNCommonWhiteColor;
        [_closeView addSubview:separateLine];
    }
    return _closeView;
}


- (UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.closeView.bottom, self.width, self.height)];
        _whiteBackView.centerX = self.width/2;
        _whiteBackView.backgroundColor = CPNCommonWhiteColor;
        _whiteBackView.layer.cornerRadius = 5.0;
        _whiteBackView.clipsToBounds = YES;
        [self addSubview:_whiteBackView];
    }
    return _whiteBackView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [self labelWithTextColor:CPNCommonMiddleBlackColor font:CPNCommonFontFifteenSize];
        _titleLabel.top = 20;
        [self.whiteBackView addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [self labelWithTextColor:CPNCommonDarkGrayColor font:CPNCommonFontFourteenSize];
        _messageLabel.left = 20;
        _messageLabel.numberOfLines = 0;
        _messageLabel.width = self.whiteBackView.width - _messageLabel.left * 2;
        [self.whiteBackView addSubview:_messageLabel];
    }
    return _messageLabel;
}


- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [self button];
        [_confirmButton setTitleColor:CPNCommonRedColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteBackView addSubview:_confirmButton];
    }
    return _confirmButton;
}


- (UIButton *)button {
    CGFloat buttonWidth = self.whiteBackView.width;
    CGFloat buttonHeight = 50;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = CPNCommonFontFifteenSize;
    [button setTitleColor:CPNCommonMaxDarkGrayColor forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    return button;
}


- (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    return label;
}


- (UIView *)buttonTopLine{
    if (_buttonTopLine == nil) {
        _buttonTopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.whiteBackView.width, 0.5)];
        _buttonTopLine.backgroundColor = CPNCommonLineLayerColorColor;
        [self.whiteBackView addSubview:_buttonTopLine];
    }
    return _buttonTopLine;
}




#pragma mark - buttonAction
- (void)clickCloseAction{
    if (self.closeButtonAction) {
        self.closeButtonAction();
    }else{
        [self dismiss];
    }
}


- (void)clickConfirmAction{
    if (self.confirmButtonAction) {
        self.confirmButtonAction();
    }else{
        [self dismiss];
    }
}


- (void)show{
    [self refreshAlertViewData];
    [[CPNPopBackView sharedInstance] displayPopBackView:self];
    [CPNPopBackView sharedInstance].alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        [CPNPopBackView sharedInstance].alpha = 1.0;
    }];
}

- (void)dismiss{
    [[CPNPopBackView sharedInstance] close];
}


-(void)removePopViewCloseGesture{
    [[CPNPopBackView sharedInstance] removeCloseGesture];
}


#pragma mark - baseFunction
- (void)refreshAlertViewData{
    
}


#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - textfieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
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
                if (textField.text.length - pointRange.location - pointRange.length >= [self validPointCount]) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (NSInteger)validPointCount{
    return 3;
}

- (void)refreshButtonFrame{
    self.confirmButton.top = self.buttonTopLine.bottom;
    self.confirmButton.hidden = NO;

    self.confirmButton.width = self.whiteBackView.width - self.confirmButton.left * 2;
    [self.confirmButton setTitle:self.confirmTitle forState:UIControlStateNormal];
    self.whiteBackView.height = MAX(150, self.confirmButton.bottom);
    self.height = self.whiteBackView.bottom;
    if (self.confirmButton.bottom >= 150) {
        return;
    }
    [self refreshSubviewsFrame];
}

- (void)refreshSubviewsFrame{
    self.whiteBackView.height = self.height - self.whiteBackView.top;
    self.confirmButton.bottom = self.whiteBackView.height;
    self.buttonTopLine.bottom = self.confirmButton.top;
    if (self.titleLabel.hidden) {
        self.messageLabel.centerY = self.buttonTopLine.top/2;
    }else{
        self.messageLabel.centerY = (self.buttonTopLine.top - self.titleLabel.bottom)/2 + self.titleLabel.bottom;
    }
}

@end
