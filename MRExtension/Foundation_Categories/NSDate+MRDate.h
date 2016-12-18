//
//  NSDate+MRDate.h
//  QZH
//
//  Created by Mr.洛洛 on 2016/11/22.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MRDate)

+ (instancetype)dateWithStampStr:(NSString *)str withDateFormat:(NSString *)dateFormat;

+ (NSDateComponents *)compareDateToNowWithDateString:(NSString *)str;

@end
