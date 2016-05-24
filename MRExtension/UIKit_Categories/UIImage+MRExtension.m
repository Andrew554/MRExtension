//
//  UIImage+MRExtension.m
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "UIImage+MRExtension.h"

@implementation UIImage (MRExtension)

#pragma mark - 拉伸图片
+ (instancetype)mr_resizingImage:(NSString *)imageName {
    
    
}


#pragma mark - 禁止渲染
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName {
    
}


#pragma mark - 带边框(optional)圆形图片裁剪
+ (instancetype)mr_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor *)borderColor {
    
}


#pragma mark - 颜色生成图片
+ (instancetype)mr_imageWithColor:(UIColor *)color {
    
    // 设置默认大小
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 获取图形上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGContextFillRect(ctx, rect);
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}


#prama mark - 控件截图
+ (instancetype)mr_imageWithCaptureView:(UIView *)view {
    
}
@end
