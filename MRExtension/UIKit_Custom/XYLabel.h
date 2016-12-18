//
//  XYLabel.h
//  XYQ
//
//  Created by JackXu on 2016/9/28.
//  Copyright © 2016年 XYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,XYVerticalAlignment)
{
    XYVerticalAlignmentTop = 0, // default
    XYVerticalAlignmentMiddle,
    XYVerticalAlignmentBottom,
} ;

@interface XYLabel : UILabel

@property (nonatomic, readonly) XYVerticalAlignment verticalAlignment;

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
