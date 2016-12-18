//
//  NSArray+JXArray.h
//  HXSD
//
//  Created by FDZ021 on 16/2/26.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MyThemeListFile @"myThemeListFile"

@interface NSArray (JXArray)

-(BOOL)saveToFileName:(NSString*)name;
+(instancetype)getFromFileName:(NSString*)name;
-(id)objectAtIndexJX:(NSUInteger)index;

@end
