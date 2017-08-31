//
//  NSString+ValidPointCount.m
//  
//
//  Created by CPN on 16/7/5.
//  Copyright © 2016年 . All rights reserved.
//

#import "NSString+ValidPointCount.h"

@implementation NSString (ValidPointCount)
/**
 *  限制浮点数的小数点后的有效位数
 *
 *  @param count 位数
 *
 *  @return
 */
- (NSString *)limitStringValidPointCount:(NSInteger)count{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:count];
    [format setMinimumIntegerDigits:1];
    NSNumber *number = [format numberFromString:self];
    NSString *string = [format stringFromNumber:number];
    
    return string;
}



/**
 *  去除浮点字符串中无效零
 *
 *  @return
 */
- (NSString *)limitStringInValidZero{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    NSString *string = [NSString stringWithFormat:@"%@",number];
    
    return string;
}


@end
