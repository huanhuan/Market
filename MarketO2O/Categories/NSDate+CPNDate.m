//
//  NSDate+CPNDate.m
//  
//
//  Created by CPN on 15/12/3.
//  Copyright © 2015年 . All rights reserved.
//

#import "NSDate+CPNDate.h"

@implementation NSDate (CPNDate)

+ (NSString *)dateWithTimeStamp:(NSInteger)timeStamp dateFormat:(NSString *)format{
    return [self dateToString:[NSDate dateWithTimeIntervalSince1970:timeStamp] format:format];
}


+ (NSString *)localDay {
    return [NSDate dateToString:[NSDate date] format:@"dd"];
}

+ (NSString *)localYearMonthDayString {
    return [NSDate dateToString:[NSDate date] format:[self defaultDateFormatString]];
}


+ (NSString *)localYearString{
    return [NSDate dateToString:[NSDate date] format:@"yyyy"];
}


+ (NSString *)localYearMonthString{
    return [NSDate dateToString:[NSDate date] format:@"yyyy.MM"];
}


+ (NSString *)localMonthString{
    return [NSDate dateToString:[NSDate date] format:@"MM"];
}


+(NSString *)localDateString{
    return [NSDate dateToString:[NSDate date] format:@"yyyy-MM-dd HH:mm"];
}


+ (NSString *)getTimeStringWithTimestamp:(NSInteger)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];
}

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (int)secondsToNextDay {
    int h= [[NSDate dateToString:[NSDate date] format:@"HH"] intValue];
    int m= [[NSDate dateToString:[NSDate date] format:@"mm"] intValue];
    int s= [[NSDate dateToString:[NSDate date] format:@"ss"] intValue];
    
    int result=24*60*60-(h*60*60+m*60+s);
    return result;
}

+ (int)weekday:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    int weekday = (int)[components weekday];
    return weekday - 1;
}


+ (NSString *)weekDateStringWithDate:(NSDate *)date{
    NSInteger week = [self weekday:date];
    switch (week) {
        case 0:
            return @"星期日";
            break;
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";

            break;
        case 3:
            return @"星期三";

            break;
        case 4:
            return @"星期四";

            break;
        case 5:
            return @"星期五";

            break;

        case 6:
            return @"星期六";
            break;
        default:
            break;
    }
    return nil;
}

/**
 *  给定日期的年份
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSInteger)yearWithDate:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


/**
 *  给定日期的月份
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSInteger)monthWithDate:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}



/**
 *  给费那个日期的具体天
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSInteger)dayWithDate:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


/**
 *  计算给定日期月份有多少天
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSInteger)totalDaysInTheMonthWithDate:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}


/**
 *  给定的日期上一个月的日期
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSDate *)previousMonthWithDate:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}



/**
 *  给定的日期下一个月份的日期
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSDate *)nextMonthWithDate:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


/**
 *  给定日期的月份第一天是星期几
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSInteger)firstWeekDayInTheMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}


+ (NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: dateFormat];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}


/**
 *  根据选中的那天生成日期
 *
 *  @param day         选中那天
 *  @param currentDate 当前月份
 *
 *  @return
 */
+ (NSDate *)dateWithDay:(NSInteger)day currentDate:(NSDate *)currentDate{
    NSInteger currentDay = [self dayWithDate:currentDate];
    NSDate *date = [NSDate dateWithTimeInterval:(day - currentDay) * 24 * 60 * 60 sinceDate:currentDate];
    return date;
}



/**
 *  根据一个给定的日期获取年月
 *
 *  @param date 给定的日期
 *
 *  @return
 */
+ (NSString *)yearAndMonthStringWithDate:(NSDate *)date{
    NSInteger year = [self yearWithDate:date];
    NSInteger month = [self monthWithDate:date];
    return [NSString stringWithFormat:@"%ld-%ld",(long)year,(long)month];
}


/**
 *  获取精简日期
 *
 *  @param formate 日期格式
 *
 *  @return
 */
- (NSDate *)dateFormate:(NSString *)formate{
    NSString *dateString =  [NSDate dateToString:self format:formate];
    return [NSDate dateFromString:dateString dateFormat:formate];
}

+ (NSString *)dateToCurrentMonthFirstStringWithDate:(NSDate *)date;
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    
    return [self dateToString:firstDay format:[self defaultDateFormatString]];
}


/**
 *  获取给定日期的所在月份的1号
 *
 *  @param date   给定日期
 *  @param format 格式
 *
 *  @return
 */
+ (NSString *)getCurrentMonthFirstDayWithDate:(NSDate *)date format:(NSString *)format{
    NSDate *firstDayDate = [self dateWithDay:1 currentDate:date];
    return [self dateToString:firstDayDate format:format];
}

///  将日期转成格式
///
///  @param dateString 日期字符串
///  @param format1    现日期字符串格式
///  @param format2    转成日期字符串格式
///
///  @return 新日期字符串
+ (NSString *) changeDateString:(NSString *)dateString fromFormat1:(NSString *)format1 toFormat2:(NSString *)format2
{
    NSDate *date = [NSDate dateFromString:dateString dateFormat:format1];
    return [NSDate dateToString:date format:format2];
}


/// 判断当前日期 是否早于 传入时间戳转换日期   yes (早于) 
+ (BOOL) judgeCurrentCompareWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *dateString = [NSDate dateToString:[NSDate date] format:[self defaultDateFormatString]];
    NSString *intoDateString = [NSDate dateWithTimeStamp:timeInterval dateFormat:[self defaultDateFormatString]];
    BOOL isResult = [dateString compare:intoDateString] == NSOrderedAscending;
    return isResult;
}



+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}


///日期格式
+ (NSString *)defaultDateFormatString{
    return @"yyyy-MM-dd";
}

/// 返回昨天
+ (NSString *)yesterdayYearMonthDayString {
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:[NSDate date]];
    return [NSDate dateToString:yesterday format:[self defaultDateFormatString]];
}

@end
