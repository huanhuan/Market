//
//  NSDate+CPNDate.h
//  
//
//  Created by CPN on 15/12/3.
//  Copyright © 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (CPNDate)
/**
 *  以时间戳返回字符串
 *
 *  @param timeStamp 时间戳
 *  @param format    时间格式
 *
 *  @return NSString
 */
+ (NSString *)dateWithTimeStamp:(NSInteger)timeStamp dateFormat:(NSString *)format;
/**
 *  把日期格式数据根据固定格式转换成字符串
 *
 *  @param date   日期
 *  @param format 格式
 *
 *  @return NSString
 */
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format;
/**
 *  当前时间日
 *
 *  @return NSString
 */
+ (NSString *)localDay;
/**
 *  返回当前年月日
 *
 *  @return NSString
 */
+ (NSString *)localYearMonthDayString;
/**
 *  返回当前年份
 *
 *  @return NSString
 */
+ (NSString *)localYearString;
/**
 *  返回当前年月
 *
 *  @return NSString
 */
+ (NSString *)localYearMonthString;
/**
 *  返回当前月份
 *
 *  @return NSString
 */
+ (NSString *)localMonthString;
/**
 *  获取当前时间
 *
 *  @return NSString
 */
+(NSString *)localDateString;
/**
 *  到明天剩余时间
 *
 *  @return int
 */
+ (int)secondsToNextDay;
/**
 *  当前星期几
 *
 *  @return int
 */
+ (int)weekday:(NSDate *)date;

/**
 返回日期所在天是星期几，字符串

 @param date 日期
 @return nssstring
 */
+ (NSString *)weekDateStringWithDate:(NSDate *)date;

/**
 *  根据时间戳转换成时间日期 yyyy.MM.dd HH:mm
 *
 *  @param timestamp 时间戳
 *
 *  @return NSString
 */
+ (NSString *) getTimeStringWithTimestamp:(NSInteger) timestamp;
/**
 *  给定日期的年份
 *
 *  @param date 给定的日期
 *
 *  @return NSInteger
 */
+ (NSInteger)yearWithDate:(NSDate *)date;
/**
 *  给定日期的月份
 *
 *  @param date 给定的日期
 *
 *  @return NSInteger
 */
+ (NSInteger)monthWithDate:(NSDate *)date;

/**
 *  给费那个日期的具体天
 *
 *  @param date 给定的日期
 *
 *  @return NSInteger
 */
+ (NSInteger)dayWithDate:(NSDate *)date;
/**
 *  计算给定日期月份有多少天
 *
 *  @param date 给定的日期
 *
 *  @return NSInteger
 */
+ (NSInteger)totalDaysInTheMonthWithDate:(NSDate *)date;
/**
 *  给定的日期上一个月的日期
 *
 *  @param date 给定的日期
 *
 *  @return NSDate
 */
+ (NSDate *)previousMonthWithDate:(NSDate *)date;
/**
 *  给定的日期下一个月份的日期
 *
 *  @param date 给定的日期
 *
 *  @return NSDate
 */
+ (NSDate *)nextMonthWithDate:(NSDate *)date;
/**
 *  给定日期的月份第一天是星期几
 *
 *  @param date 给定的日期
 *
 *  @return NSInteger
 */
+ (NSInteger)firstWeekDayInTheMonthWithDate:(NSDate *)date;

/**
 *  根据选中的那天生成日期
 *
 *  @param day         选中那天
 *  @param currentDate 当前月份
 *
 *  @return NSDate
 */
+ (NSDate *)dateWithDay:(NSInteger)day currentDate:(NSDate *)currentDate;


/**
 *  根据一个给定的日期获取年月
 *
 *  @param date 给定的日期
 *
 *  @return NSString
 */
+ (NSString *)yearAndMonthStringWithDate:(NSDate *)date;


/**
 *  获取精简日期
 *
 *  @param formate 日期格式
 *
 *  @return NSDate
 */
- (NSDate *)dateFormate:(NSString *)formate;

/**
 *  根据日期字符串生成日期
 *
 *  @param dateString 日期字符串
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;


/**
 *  获取给定日期的所在月份的1号
 *
 *  @param date   给定日期
 *  @param format 格式
 *
 *  @return NSString
 */
+ (NSString *)getCurrentMonthFirstDayWithDate:(NSDate *)date format:(NSString *)format;

///  根据传入日期 获取传入日期 当月 1 号
+ (NSString *)dateToCurrentMonthFirstStringWithDate:(NSDate *)date;

///  将日期转成格式
///
///  @param dateString 日期字符串
///  @param format1    现日期字符串格式
///  @param format2    转成日期字符串格式
///
///  @return 新日期字符串
+ (NSString *) changeDateString:(NSString *)dateString fromFormat1:(NSString *)format1 toFormat2:(NSString *)format2;


/// 判断当前日期 是否早于 传入时间戳转换日期   yes (早于) no (等于或者大与)
+ (BOOL) judgeCurrentCompareWithTimeInterval:(NSTimeInterval)timeInterval;

///日期格式
+ (NSString *)defaultDateFormatString;


/**
 *  根据日期字符串生成日期
 *
 *  @param dateString 日期字符串
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/// 返回昨天
+ (NSString *)yesterdayYearMonthDayString;

@end
