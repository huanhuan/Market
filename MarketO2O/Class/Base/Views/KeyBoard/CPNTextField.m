//
//  CPNTextField.m
//  
//
//  Created by CPN on 16/3/2.
//  Copyright © 2016年 . All rights reserved.
//

#import "CPNTextField.h"

@interface CPNTextField ()

@property (nonatomic,strong)UIView *doneButtonView;

@end


@implementation CPNTextField


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.inputAccessoryView = self.doneButtonView;
        self.limitMaxLenth = NSIntegerMax;
        self.validPointCount = 3;        
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    }
    return self;
}


- (UIView *)doneButtonView{
    if (!_doneButtonView) {
        _doneButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 44)];
        _doneButtonView.backgroundColor = CPNCommonLineLayerColorColor;
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        doneButton.backgroundColor = [UIColor clearColor];
        [doneButton setTitleColor:CPNCommonMiddleBlueColor forState:UIControlStateNormal];
        [doneButton setTitle:@"完成" forState:UIControlStateNormal];
        doneButton.titleLabel.font = CPNCommonFontFifteenSize;
        [doneButton addTarget:self action:@selector(clickDoneInput) forControlEvents:UIControlEventTouchUpInside];
        doneButton.frame = CGRectMake(0, 0, 60, _doneButtonView.height);
        doneButton.right = _doneButtonView.width;
        [_doneButtonView addSubview:doneButton];
    }
    return _doneButtonView;
}



- (void)clickDoneInput{
    [self resignFirstResponder];
}




- (void)layoutIfNeeded{
    [super layoutIfNeeded];
    if (self.keyboardType != UIKeyboardTypeDecimalPad
        && self.keyboardType != UIKeyboardTypeNumberPad
        && self.keyboardType != UIKeyboardTypePhonePad) {
        self.inputAccessoryView = nil;
    }else{
        self.inputAccessoryView = self.doneButtonView;
    }
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    BOOL isBool = [super canPerformAction:action withSender:sender];
    if (action == @selector(paste:)) {
        if (self.keyboardType == UIKeyboardTypeDecimalPad
            || self.keyboardType == UIKeyboardTypeNumberPad
            || self.keyboardType == UIKeyboardTypePhonePad){
            isBool = NO;
        }
    }
    return isBool;
}




+ (CPNTextField *)textFieldWithFrame:(CGRect)frame
                           textColor:(UIColor *)textColor
                            textFont:(UIFont *)textFont
                          placeehold:(NSString *)placeHold
                   textFieldDelegate:(id <UITextFieldDelegate>)textFieldDelegate
                textEditChangeAction:(SEL)editChangeSelector{
    CPNTextField *textField = [[CPNTextField alloc] initWithFrame:frame];
    textField.textColor = textColor;
    textField.font = textFont;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = textFieldDelegate;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (editChangeSelector) {
        [textField addTarget:textFieldDelegate action:editChangeSelector forControlEvents:UIControlEventEditingChanged];
    }
    [textField setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeHold];
    [placeholder addAttribute:NSFontAttributeName
                       value:textFont
                       range:NSMakeRange(0, placeHold.length)];
    textField.attributedPlaceholder = placeholder;
    return textField;
}

@end
