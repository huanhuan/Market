//
//  CPNCommonButton.m
//  
//
//  Created by CPN on 16/3/18.
//  Copyright © 2016年 . All rights reserved.
//

#import "CPNCommonButton.h"


@interface CPNCommonButton()

/**
 *  图片位置
 */
@property (nonatomic, assign)CPNImageAndTitleButtonImagePosition imagePosition;


@end

@implementation CPNCommonButton

+ (instancetype)commonButtonWithNormalImageName:(NSString*)normalImgName
                           heightLightImageName:(NSString*)heightLightImageName
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    btn.exclusiveTouch = YES;
    if (![CPNInputValidUtil isBlinkString:heightLightImageName]) {
        [btn setImage:[UIImage imageNamed:heightLightImageName] forState:UIControlStateHighlighted];
    }else{
        [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateHighlighted];
    }
    
    return btn;
}

+(instancetype) commonButtonWithTitle:(NSString *)title
                        selectedTitle:(NSString *)selectedTitle
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn sizeToFit];
    btn.exclusiveTouch = YES;
    return btn;
}

+(instancetype) commonButtonWithTitle:(NSString *)title
                        andTitleColor:(UIColor *) titleColor
                                 font:(UIFont*)font
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn sizeToFit];
    return  btn;
}

+(instancetype) commonButtonWithTitle:(NSString *)title
                        andTitleColor:(UIColor *) titleColor
                                 font:(UIFont*)font
                         cornerRadius:(CGFloat) radius
                       andBorderColor:(UIColor *)borderColor
                       andBorderWidth:(CGFloat)borderWith
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.layer.cornerRadius = radius;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWith;
    btn.layer.masksToBounds = YES;
    btn.exclusiveTouch = YES;
    return  btn;
}


+ (instancetype)commonButtonWithTitle:(NSString*)title
                        andTitleColor:(UIColor*)titleColor
                                 font:(UIFont*)font
                         cornerRadius:(CGFloat)radius
                       backGroudColor:(UIColor *)backGroudColor
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.exclusiveTouch = YES;
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundColor:backGroudColor];
    return  btn;
}



+ (instancetype)commonButtonWithTitle:(NSString *)title
                                   font:(UIFont *)font
                             titleColor:(UIColor *)titleColor
                              imageName:(NSString *)imageName
                        imagePosition:(CPNImageAndTitleButtonImagePosition)imagePosition
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.exclusiveTouch = YES;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (![CPNInputValidUtil isBlinkString:imageName]) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    btn.imagePosition = imagePosition;
    return btn;
}


+(instancetype) commonButtonWithTitle:(NSString *)title
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
                   selectedTitleColor:(UIColor *)selectedTitleColor
                            imageName:(NSString *)imageName
                 selectedImageName:(NSString *)selectedImageName
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];

    btn.titleLabel.font = font;
    btn.exclusiveTouch = YES;

    return btn;
}


+ (instancetype)commonButtonWithTitle:(NSString *)title
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
                            imageName:(NSString *)imageName
                         cornerRadius:(CGFloat) radius
                       andBorderColor:(UIColor *)borderColor
                       andBorderWidth:(CGFloat)borderWith
                          titleOffset:(CGFloat)titleOffset
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    UIImage *img = [UIImage imageNamed:imageName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btn setImage:img forState:UIControlStateNormal];
    btn.layer.cornerRadius = radius;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWith;
    btn.layer.masksToBounds = YES;
    btn.exclusiveTouch = YES;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, titleOffset, 0, 0);
    return btn;
}


+ (instancetype)commonButtonWithNormalTitle:(NSString *)normalTitle
                              selectedTitle:(NSString *)selectedTitle
                                       font:(UIFont *)font
                           normalTitleColor:(UIColor *)normalTitleColor
                         selectedTitleColor:(UIColor *)selectedTitleColor{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    btn.exclusiveTouch = YES;
    return btn;
}


+ (instancetype)commonButtonWithTitle:(NSString *)title
                                 font:(UIFont *)font
                           titleColor:(UIColor *)titleColor
                            imageName:(NSString *)imageName
                    selectedImageName:(NSString *)selectedImageName
                      enableImageName:(NSString *)enableIamgeName
{
    CPNCommonButton *btn = [[CPNCommonButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.exclusiveTouch = YES;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (![CPNInputValidUtil isBlinkString:imageName]) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    if (![CPNInputValidUtil isBlinkString:selectedImageName]) {
        [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    if (![CPNInputValidUtil isBlinkString:enableIamgeName]) {
        [btn setImage:[UIImage imageNamed:enableIamgeName] forState:UIControlStateDisabled];
    }
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    switch (self.imagePosition) {
        case CPNImageAndTitleButtonImagePositionRight:{
            CGRect rect = self.imageView.frame;
            CGFloat titleY = (self.height - self.titleLabel.height) * 0.5;
            CGFloat titleW = self.titleLabel.width;
            CGFloat titleH = self.titleLabel.height;
            if (self.imageView.frame.size.width > 0) {
                self.titleLabel.frame = CGRectMake(0 , titleY, titleW, titleH);
                CGFloat imgX = self.width - rect.size.width - 5;
                self.imageView.frame = CGRectMake(imgX, rect.origin.y, rect.size.width, rect.size.height);
            }
        }
            break;
        default:
            break;
    }
}

@end
