//
//  CPNLoginButtonView.h
//  FastRecord
//
//  Created by CPN on 16/6/23.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNTextField.h"

@interface CPNLabelAndTextFieldView : UIView

@property (nonatomic, strong) UILabel                   *tipLabel;
@property (nonatomic, strong) CPNTextField              *textField;
@property (nonatomic, strong) UIView                    *separateLine;

@property (nonatomic, copy  ) void (^textFieldEditChangeAction)();


- (instancetype)initWithFrame:(CGRect)frame
                      tipText:(NSString *)tipText
                 tipTextColor:(UIColor *)tipColor
                      tipFont:(UIFont *)tipFont
           textFieldTextColor:(UIColor *)textColor
            textFieldTextFont:(UIFont *)textFont
           textFieldPlaceHold:(NSString *)placeHold;

- (void)removeSeparateLine;

- (void)setSeparateLineHidden:(BOOL)hidden;

@end
