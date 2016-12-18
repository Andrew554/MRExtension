//
//  MRSegment.h
//  MRChannelSegment
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRSegment;

@protocol MRSegmentDelegate <NSObject>

- (void)MRSegment:(MRSegment*)segment didSelectIndex:(NSInteger)index;
- (void)MRSegment:(MRSegment*)segment didClickAddButton:(UIButton*)button;

@end


@interface MRSegment : UIControl

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,assign) BOOL showAddButton;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,weak) id<MRSegmentDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame isShow:(BOOL)show;
- (void)updateChannels:(NSArray*)array;
- (void)updateChannels:(NSArray*)array image:(NSArray*)images;
- (void)didChengeToIndex:(NSInteger)index;

@end
