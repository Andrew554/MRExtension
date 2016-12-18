//
//  NSDate+MRDate.m
//  QZH
//
//  Created by Mr.洛洛 on 2016/11/22.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "NSDate+MRDate.h"

@implementation NSDate (MRDate)

+ (instancetype)dateWithStampStr:(NSString *)str withDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    return [formatter dateFromString:str];
}

+ (NSDateComponents *)compareDateToNowWithDateString:(NSString *)str {
    // 当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 获取截至日期的字符串格式
    NSString *expireDateStr = str;
//    // 当前日期的字符串格式
//    NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
    // 截至日期date格式
    NSDate *expireDate = [dateFormatter dateFromString:expireDateStr];
    // 当前日期date格式
//    nowDate = [dateFormatter dateFromString:nowDateStr];
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 设置需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCompare = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    return dateCompare;
}

@end
