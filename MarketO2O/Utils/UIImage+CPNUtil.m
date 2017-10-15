//
//  UIImage+CPNUtil.m
//  MarketO2O
//
//  Created by phh on 2017/10/15.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "UIImage+CPNUtil.h"

@implementation UIImage (CPNUtil)

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
