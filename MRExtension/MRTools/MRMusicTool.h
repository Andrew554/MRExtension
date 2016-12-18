//
//  MRMusicTool.h
//  工具
//
//  Created by Andrew554 on 16/8/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRMusic;

@interface MRMusicTool : NSObject

+ (void)setMusicNames:(NSArray *)musicNames;

+ (NSArray *)musics;

+ (MRMusic *)playingMusic;

+ (void)setPlayingMusic:(MRMusic *)playingMusic;

+ (MRMusic *)nextMusic;

+ (MRMusic *)previousMusic;

@end
