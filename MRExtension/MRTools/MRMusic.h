//
//  MRMusic.h
//  工具
//
//  Created by Andrew554 on 16/8/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRMusic : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *lrcname;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, strong) NSData *singerIcon;
@property (nonatomic, strong) NSData *icon;

@end
