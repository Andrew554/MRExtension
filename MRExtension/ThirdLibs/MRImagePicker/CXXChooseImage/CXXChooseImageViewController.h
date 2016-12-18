//
//  CXXChooseImageViewController.h
//  CXXChooseImage
//
//  Created by Qun on 16/9/30.
//  Copyright © 2016年 Qun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXXChooseImageViewControllerDelegate <NSObject>
@optional
- (void)chooseImageViewControllerDidChangeCollectionViewWidth:(CGFloat)width Heigh:(CGFloat)height;
@end

@interface CXXChooseImageViewController : UIViewController

/** 最大可选择图片个数 */
@property (nonatomic, assign) NSInteger maxImageCount;

/** 选择的图片数据源 */
@property (nonatomic, strong) NSMutableArray *dataArr;

/** 图片是否可编辑 */
@property (nonatomic, assign) BOOL allowsEditing;

/** delegate */
@property (nonatomic, weak) id <CXXChooseImageViewControllerDelegate>delegate;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *   origin collectionView.origin
 *
 *   itemSize item的size = CGSizeMake(0, 0) 默认collectionView.width = window.width
 *
 *   rowCount 一行几个item = 0 默认 rowCount = 4
 */
- (void)setOrigin:(CGPoint)origin ItemSize:(CGSize)itemSize rowCount:(NSInteger)rowCount;
@end
