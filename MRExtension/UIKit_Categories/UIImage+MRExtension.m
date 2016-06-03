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
    
    // 根据图片名创建图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 找到可拉伸的区域
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    // 获取将图片中间 1*1 拉伸填充铺满之后的新图片
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5 - 1, imageW * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
    
    return image;
}


#pragma mark - 禁止渲染
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName {
    
    // 根据图片名创建图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 告诉系统不需要渲染，保持图片原始状态
    image = [image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 返回新的图片
    return image;
}


#pragma mark - 带边框(optional)圆形图片裁剪
+ (instancetype)mr_imageWithClipImage:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    // 设置圆环宽度
    CGFloat border = borderWidth;
    
    // 图片宽高
    CGFloat imageWH = clipImage.size.width;
    
    // 设置外框尺寸
    CGFloat ovalWH = imageWH + 2 *border;
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    // 填充
    [path fill];
    
    // 设置圆形裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    [clipPath addClip];
    
    // 绘制图片
    [clipImage drawAtPoint:CGPointMake(border, border)];
    
    // 从上下文获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}


#pragma mark - 颜色生成图片
+ (instancetype)mr_imageWithColor:(UIColor *)color {
    
    // 设置默认大小
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 获取图形上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 填充颜色
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    // 图片填充大小
    CGContextFillRect(ctx, rect);
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}


#pragma mark - 控件截图
+ (instancetype)mr_imageWithCaptureView:(UIView *)view {
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);

    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 将控件上的图层渲染上下文
    [view.layer renderInContext:ctx];
    
    // 生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

#pragma mark - 根据CIImage生成指定大小的UIImage
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (instancetype)mr_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark - 快速生成二维码
+ (instancetype)mr_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size
{
    return [UIImage mr_createQRCodeWithInputData:inputData centerImage:nil size:size];
}


#pragma mark - 快速生成中间有图片的二维码
+ (instancetype)mr_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size
{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.设置相关属性
    [filter setDefaults];
    
    // 3.设置输入源
    [filter setValue:inputData forKeyPath:@"inputMessage"];
    
    // 4.获取输出结果(直接使用该图片显示到view上回比较模糊)
    CIImage *outputImage = [filter outputImage];
    
    // 5.图片处理
    UIImage *image = [UIImage mr_createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    
    if (centerImage) {
        
        UIImageView *imageView =[self imageViewWithImage:image centerImage:centerImage];
        
        return [UIImage mr_imageWithCaptureView:imageView]; // 控件截图
    }else {
        return image;
    }
}

#pragma mark - 嵌套圆形
+ (UIImageView *)imageViewWithImage:(UIImage *)image centerImage:(UIImage *)centerImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    UIImageView *centerImageView = [[UIImageView alloc]init];
    
    CGFloat centerImageHW = 90; // 设置默认宽高
    // 居中显示
    CGFloat centerImageX = (imageView.bounds.size.width - centerImageHW) * 0.5;
    CGFloat centerImageY = (imageView.bounds.size.height - centerImageHW) * 0.5;;
    // 设置frame
    centerImageView.frame = CGRectMake(centerImageX, centerImageY, centerImageHW, centerImageHW);
    centerImageView.image = centerImage;
    centerImageView.layer.borderWidth = 5; // 默认边框宽度
    centerImageView.layer.cornerRadius = 10;// 默认圆角半径
    centerImageView.layer.borderColor = [UIColor whiteColor].CGColor;//默认边框颜色
    centerImageView.layer.masksToBounds = YES;
    [imageView addSubview:centerImageView];
    return imageView;
}

#pragma mark - 快速生成一张黑白图片
+ (instancetype)mr_createMonochromeWithOriginalImage:(UIImage *)image withSize:(CGFloat)size;
{
    CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
    
    return [UIImage mr_createNonInterpolatedUIImageFormCIImage:ciimage withSize:size];
}
@end
