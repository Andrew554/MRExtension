//
//  MRMusicTool.m
//  工具
//
//  Created by Andrew554 on 16/8/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MRMusicTool.h"
#import "MRMusic.h"

@implementation MRMusicTool

static NSMutableArray *_musics;
static MRMusic *_playingMusic;

+ (void)initialize
{
    if (_musics == nil) {
        _musics = [NSMutableArray array];
    }
    
    if (_playingMusic == nil) {
        _playingMusic = _musics[1];
    }
}


+ (void)setMusicNames:(NSArray *)musicNames {
 
    for (NSInteger i = 0; i < musicNames.count; i++) {
        //获取本地地址
        NSString *name = [musicNames[i] stringByAppendingString:@".mp3"];
        NSURL *url = [[NSBundle mainBundle] URLForAuxiliaryExecutable:name];
        //解析歌曲
        MRMusic *model = [[MRMusic alloc] init];
        //解析元数据
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        //可用的格式
        NSArray *formats = [asset availableMetadataFormats];
        //遍历
        for (NSString *format in formats) {
            //解析元数据
            NSArray *items = [asset metadataForFormat:format];
            for (AVMetadataItem *item in items) {
                //歌曲名字
                if ([item.commonKey isEqualToString:AVMetadataCommonKeyTitle]) {
                    model.name = (NSString *)item.value;
                }
                //专辑名
                if ([item.commonKey isEqualToString:AVMetadataCommonKeyAlbumName]) {
                    model.filename = (NSString *)item.value;
                }
                //艺术家
                if ([item.commonKey isEqualToString:AVMetadataCommonKeyArtist]) {
                    model.singer = (NSString *)item.value;
                }
                //专辑图片
                if ([item.commonKey isEqualToString:AVMetadataCommonKeyArtwork]) {
                    model.icon = (NSData *)item.value;
                }
            }
        }
        
        // 添加
        [_musics addObject:model];
    }
}

+ (NSArray *)musics
{
    return _musics;
}

+ (MRMusic *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(MRMusic *)playingMusic
{
    _playingMusic = playingMusic;
}

+ (MRMusic *)nextMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= _musics.count) {
        nextIndex = 0;
    }
    MRMusic *nextMusic = _musics[nextIndex];
    
    return nextMusic;
}

+ (MRMusic *)previousMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = _musics.count - 1;
    }
    MRMusic *previousMusic = _musics[previousIndex];
    
    return previousMusic;
}


@end
