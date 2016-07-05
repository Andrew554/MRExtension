//
//  NSDictionary+Log.m
//  MRExtension
//
//  Created by Andrew554 on 16/7/5.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

# import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    
    NSMutableString *string = [NSMutableString string];

    [string appendString:@"{\n"]; // 开头的大括号{
    
    // 遍历key、value
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
        
    }];
    
    [string appendString:@"}"];  // 结尾的大括号}
    
    // 搜索最后一个逗号的范围
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    
    // 删除最后一个元素的逗号
    if(range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"[\n"]; // 开头的中括号[
    
    // 遍历数组元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
        [string appendFormat:@"\t%@,\n", obj];
    }];
     
    [string appendString:@"]"];  // 结尾的中括号]
    
    // 搜索最后一个逗号的范围
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    
    // 删除最后一个元素的逗号
    if(range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}

@end
