//
//  CPNCommonButton.h
//  
//
//  Created by CPN on 16/3/18.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNImageAndTitleButton.h"


@interface CPNCommonButton : UIButton

/**
 *  快速创建Btn 高亮图片可为空，包含属性：normalImgName，heightLightImageName
 *
 *  @param normalImgName        普通图片名称
 *  @param heightLightImageName 高亮图片名称
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithNormalImageName:(NSString*)normalImgName
                           heightLightImageName:(NSString*)heightLightImageName;

/**
 *  快速创建btn title selectedTitle font titleColor anyObject actionName
 *
 *  @param title         按钮文字
 *  @param selectedTitle 选中按钮文字
 *  @param font          字体大小
 *  @param titleColor    字体颜色
 *
 *  @return CPNCommonButton
 */
+(instancetype) commonButtonWithTitle:(NSString *)title
                        selectedTitle:(NSString *)selectedTitle
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor;


/**
 *  快速创建按钮，包含属性：title，font，titleColor，radius，borderColor，borderWith
 *
 *  @param title       按钮文字
 *  @param titleColor  按钮文字颜色
 *  @param radius      按钮layer裁剪边境
 *  @param borderColor layer边线颜色
 *  @param borderWith  layer边线宽度
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithTitle:(NSString*)title
                        andTitleColor:(UIColor*)titleColor
                                 font:(UIFont*)font
                         cornerRadius:(CGFloat)radius
                       andBorderColor:(UIColor*)borderColor
                       andBorderWidth:(CGFloat)borderWith;

/**
 *  快速创建按钮，包含属性：title，font，titleColor，radius backGroudColor anyObject actionName
 *
 *  @param title            按钮文字
 *  @param titleColor       按钮文字颜色
 *  @param radius           按钮layer裁剪边境
 *  @param backGroudColor   按钮背景颜色
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithTitle:(NSString*)title
                        andTitleColor:(UIColor*)titleColor
                                 font:(UIFont*)font
                         cornerRadius:(CGFloat)radius
                       backGroudColor:(UIColor*)backGroudColor;

/**
 *  快速创建Btn，包含属性：title，font，titleColor，imageName，imagePosition
 *
 *  @param title      文字
 *  @param font       字体
 *  @param titleColor 字体颜色
 *  @param imageName  图片
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithTitle:(NSString*)title
                                 font:(UIFont*)font
                           titleColor:(UIColor*)titleColor
                            imageName:(NSString*)imageName
                        imagePosition:(CPNImageAndTitleButtonImagePosition)imagePosition;

/**
 *  快速创建Btn，包含属性：title，font，titleColor，imageName，radius，borderColor，borderWith，titleOffset，imagePosition
 *
 *  @param title      文字
 *  @param font       字体
 *  @param titleColor 字体颜色
 *  @param imageName  图片
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithTitle:(NSString*)title
                                 font:(UIFont*)font
                           titleColor:(UIColor*)titleColor
                            imageName:(NSString*)imageName
                         cornerRadius:(CGFloat)radius
                       andBorderColor:(UIColor*)borderColor
                       andBorderWidth:(CGFloat)borderWith
                          titleOffset:(CGFloat)titleOffset;


/**
 *  快速创建按钮，包含属性：normalTitle，selectedTitle，font，normalTitleColor，selectedTitleColor
 *
 *  @param normalTitle        正常状态下的按钮标题
 *  @param selectedTitle      选中状态下的标题
 *  @param font               字体大小
 *  @param normalTitleColor   正常状态下的标题颜色
 *  @param selectedTitleColor 选中状态下的标题颜色
 *
 *  @return CPNCommonButton
 */
+ (instancetype)commonButtonWithNormalTitle:(NSString*)normalTitle
                              selectedTitle:(NSString*)selectedTitle
                                       font:(UIFont*)font
                           normalTitleColor:(UIColor*)normalTitleColor
                         selectedTitleColor:(UIColor*)selectedTitleColor;
/**
 *  快速创建按钮，包含属性：normalTitle，font，normalTitleColor
 *
 *  @param title      文字
 *  @param titleColor 文字颜色
 *  @param font       字体
 *
 *  @return CPNCommonButton
 */
+(instancetype) commonButtonWithTitle:(NSString *)title
                        andTitleColor:(UIColor *) titleColor
                                 font:(UIFont*)font;

///  创建按钮  文字 字体 颜色 选中字体颜色 图片 选中图片
///
///  @param title              文字
///  @param font               字体
///  @param titleColor         字体颜色
///  @param selectedTitleColor 选中字体颜色
///  @param imageName          图片
///  @param selectedImageName  选择图片
///
///  @return CPNCommonButton
+(instancetype) commonButtonWithTitle:(NSString *)title
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
                   selectedTitleColor:(UIColor *)selectedTitleColor
                            imageName:(NSString *)imageName
                    selectedImageName:(NSString *)selectedImageName;



/**
 创建按钮  文字, 字体 字体颜色, 图片 选中图片 不能操作图片

 @param title 文字
 @param font 字体
 @param titleColor 字体颜色
 @param imageName 图片
 @param selectedImageName 选中图片
 @param enableIamgeName 不能操作图片
 @return 按钮
 */
+ (instancetype)commonButtonWithTitle:(NSString *)title
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
                            imageName:(NSString *)imageName
                    selectedImageName:(NSString *)selectedImageName
                      enableImageName:(NSString *)enableIamgeName;
@end
