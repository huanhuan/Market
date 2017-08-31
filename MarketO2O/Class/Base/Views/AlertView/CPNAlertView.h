//
//  CPNAlertView.h
//  
//
//  Created by CPN on 15/11/30.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>


@class CPNTextField;


typedef void ((^CPNAlertButtonActionBlock)());

@interface CPNAlertView : UIView <UITextFieldDelegate>
/**
 *  取消按钮block事件（左边按钮）
 */
@property (nonatomic,copy  ) CPNAlertButtonActionBlock         closeButtonAction;
/**
 *  确定按钮block事件（右边按钮）
 */
@property (nonatomic,copy  ) CPNAlertButtonActionBlock         confirmButtonAction;

/**
 *  按钮顶部水平分割线
 */
@property (nonatomic,strong) UIView                            *buttonTopLine;

/**
 *  标题显示的label
 */
- (UILabel *)titleLabel;

/**
 *  附加信息显示的label
 */
- (UILabel *)messageLabel;

/**
 确定按钮

 @return button
 */
- (UIButton *)confirmButton;


/**
 白色背景

 @return view
 */
- (UIView *)whiteBackView;

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
       confirmTitle:(NSString *)confirmTitle;


/**
 *  显示弹框
 */
- (void)show;
/**
 *  消除弹框
 */
- (void)dismiss;

/**
 *  刷新数据
 */
- (void)refreshAlertViewData;

/**
 *  刷新按钮坐标
 */
- (void)refreshButtonFrame;

/**
 *  创建label
 *
 *  @param textColor label字体颜色
 *  @param font      label字体
 *
 *  @return CPNAlertView
 */
- (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

/**
 确定好整个弹窗的高度，刷新子类view坐标
 */
- (void)refreshSubviewsFrame;


@end
