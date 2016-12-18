//
//  MRTextView.h
//  QZH
//
//  Created by CodeLL on 2016/11/7.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTextView : UITextView

@property (nonatomic, strong) UIFont *myplaceholderFont;// 占位符字体

@property(nonatomic,copy) NSString *myPlaceholder;  //文字

@property(nonatomic,strong) UIColor *myPlaceholderColor; //文字颜色

@end
