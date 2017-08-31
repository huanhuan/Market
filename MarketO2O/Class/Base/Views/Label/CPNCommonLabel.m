//
//  CPNApprovalCellLabel.m
//  
//
//  Created by 1 on 15/11/19.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNCommonLabel.h"

@implementation CPNCommonLabel

+(instancetype)commonLabelWithTitleFont:(UIFont *)font andTextColor:(UIColor *)color
{
    CPNCommonLabel *lbl = [[CPNCommonLabel alloc] init];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = color;
    lbl.font = font;
    return lbl;
}


+ (instancetype) commonLabelWithTitle:(NSString *)title
                               textFont:(UIFont *)font
                              textColor:(UIColor *)color
{
    CPNCommonLabel *lbl = [[CPNCommonLabel alloc] init];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = title;
    lbl.font = font;
    lbl.textColor = color;
    lbl.numberOfLines = 0;
    [lbl sizeToFit];
    return lbl;
}

+ (instancetype) commonLabelWithTitle:(NSString *)title
                               textFont:(UIFont *)font
                              textColor:(UIColor *)color
                            borderColor:(UIColor *)borderColor
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
{
    CPNCommonLabel *lbl = [CPNCommonLabel commonLabelWithTitle:title textFont:font textColor:color];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = font;
    lbl.text = title;
    lbl.textColor = color;
    lbl.layer.cornerRadius = cornerRadius;
    lbl.clipsToBounds = YES;
    lbl.layer.borderColor = borderColor.CGColor;
    lbl.layer.borderWidth = borderWidth;
    [lbl sizeToFit];
    lbl.textAlignment = NSTextAlignmentCenter;
    
    return lbl;
}
/**
 *  创建label 文字 字体大小 字体颜色 边框 背景色
 *
 *  @param title           文字
 *  @param font            字体大小
 *  @param color           字体颜色
 *  @param cornerRadius    边框弧度
 *  @param backGroundColor 背景色
 *
 *  @return
 */
+ (instancetype) commonLabelWithTitle:(NSString *)title
                             textFont:(UIFont *)font
                            textColor:(UIColor *)color
                         cornerRadius:(CGFloat)cornerRadius
                      backGroundColor:(UIColor *)backGroundColor
{
    CPNCommonLabel *lbl = [CPNCommonLabel commonLabelWithTitle:title textFont:font textColor:color];
    lbl.font = font;
    lbl.text = title;
    lbl.textColor = color;
    lbl.layer.cornerRadius = cornerRadius;
    lbl.clipsToBounds = YES;
    lbl.backgroundColor = backGroundColor;
//    lbl.textAlignment = NSTextAlignmentCenter;
    
    return lbl;
}

+ (instancetype) commonLabelWithTitle:(NSString *)title
                             textFont:(UIFont *)font
                            textColor:(UIColor *)color
                              corners:(UIRectCorner)corners
                         cornerRadius:(CGFloat)cornerRadius
                            backColor:(UIColor *)backColor
{
    CPNCommonLabel *lbl = [CPNCommonLabel commonLabelWithTitle:title textFont:font textColor:color];
    lbl.backgroundColor = backColor;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.layer.cornerRadius = cornerRadius;
    lbl.clipsToBounds = YES;
    return lbl;
}

@end
