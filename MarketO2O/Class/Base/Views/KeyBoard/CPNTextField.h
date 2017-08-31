//
//  CPNTextField.h
//  
//
//  Created by CPN on 16/3/2.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPNTextField : UITextField

@property (nonatomic, assign) NSInteger validPointCount;

@property (nonatomic, assign) NSInteger limitMaxLenth;


+ (CPNTextField *)textFieldWithFrame:(CGRect)frame
                           textColor:(UIColor *)textColor
                            textFont:(UIFont *)textFont
                          placeehold:(NSString *)placeHold
                   textFieldDelegate:(id <UITextFieldDelegate>)textFieldDelegate
                textEditChangeAction:(SEL)editChangeSelector;

@end
