//
//  NSString+XYString.m
//  XYQ
//
//  Created by FDZ021 on 2016/9/29.
//  Copyright © 2016年 XYQ. All rights reserved.
//

#import "NSString+XYString.h"

@implementation NSString (XYString)

-(CGSize)sizeWithfont:(UIFont*)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    JXLog(@"dynamicSizeLog: %@---%@", self, NSStringFromCGSize(size));
    return size;
}

- (CGSize)sizeWithStyleFont:(UIFont*)font maxSize:(CGSize)maxSize {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];  // 行间距
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSKernAttributeName : @(0.5f)}]; // 字间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f};
    CGSize size =[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

+(instancetype)stringWithTimeStampNum:(NSInteger)timeStampNum {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStampNum/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:MM"];
    return [formatter stringFromDate:confromTimesp];
}
@end
