//
//  NSString+XYString.h
//  XYQ
//
//  Created by FDZ021 on 2016/9/29.
//  Copyright © 2016年 XYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYString)

/**
 *  字符串长高
 **/
-(CGSize)sizeWithfont:(UIFont*)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithStyleFont:(UIFont*)font maxSize:(CGSize)maxSize;

/** 
 *  根据时间戳返回对应的时间字符串
 **/
+(instancetype)stringWithTimeStampNum:(NSInteger) timeStampNum;

@end
