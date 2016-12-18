//
//  MRRadioView.h
//  QZH
//
//  Created by CodeLL on 2016/11/8.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRRadioView : UIView

@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array numsForColumn:(NSInteger)nums;

@end
