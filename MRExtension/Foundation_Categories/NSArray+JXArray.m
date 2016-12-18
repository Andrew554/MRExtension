//
//  NSArray+JXArray.m
//  HXSD
//
//  Created by FDZ021 on 16/2/26.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "NSArray+JXArray.h"

@implementation NSArray (JXArray)

-(BOOL)saveToFileName:(NSString*)name{
    NSString *home = NSHomeDirectory();
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    BOOL isOk = [self writeToFile:filePath atomically:YES];
    NSLog(@"保存:%@到本地，%@",name,isOk?@"成功":@"失败");
    return isOk;
}

+(instancetype)getFromFileName:(NSString*)name{
    NSString *home = NSHomeDirectory();
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;
}

#pragma mark - 安全访问
-(id)objectAtIndexJX:(NSUInteger)index{
    if ([self count] > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}


@end
