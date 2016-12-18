//
//  MRPageView.h
//  MRChannelSegment
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRPageView;

@protocol MRPageViewDataSource <NSObject>

- (NSInteger)numberOfItemInMRPageView:(MRPageView*)pageView;
- (UIView*)pageView:(MRPageView*)pageView viewAtIndex:(NSInteger)index;

@end

@protocol MRPageViewDelegate <NSObject>

- (void)didScrollToIndex:(NSInteger)index;

@end


@interface MRPageView : UIView

@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,assign) NSInteger numberOfItems;
@property(nonatomic,assign) BOOL scrollAnimation;
@property(nonatomic,weak) id<MRPageViewDataSource> datasource;
@property(nonatomic,weak) id<MRPageViewDelegate> delegate;

- (void)reloadData;
- (void)changeToItemAtIndex:(NSInteger)index;

@end
