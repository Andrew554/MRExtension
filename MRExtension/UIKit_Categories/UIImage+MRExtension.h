//
//  UIImage+MRExtension.h
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MRExtension)

/**
 *	@brief	生成可拉伸的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	可拉伸的图片
 */
+ (instancetype)mr_resizingImage:(NSString *)imageName;


/**
 *	@brief	生成一张禁止用系统渲染的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	禁用系统渲染的图片
 */
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName;


/**
 *	@brief	带边框(optional)圆形图片裁剪
 *
 *	@param 	clipImageName 	待裁剪图片名
 *	@param 	borderWidth 	圆环宽度
 *	@param 	borderColor 	圆环颜色
 *
 *	@return	裁剪之后的图片
 */
+ (instancetype)mr_imageWithClipImage:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 *	@brief	根据颜色生成一张尺寸为 1*1 的相同颜色图片
 *
 *	@param 	color 	需要转化的颜色
 *
 *	@return	生成一张尺寸为 1*1 相同颜色的图片
 */
+ (instancetype)mr_imageWithColor:(UIColor *)color;


/**
 *	@brief	根据控件返回一张截图
 *
 *	@param 	view 	来源控件
 *
 *	@return	控件截图
 */
+ (instancetype)mr_imageWithCaptureView:(UIView *)view;


/**
 *	@brief	嵌套圆形图片
 *
 *	@param 	image 	外圆形
 *	@param 	centerImage 	中心圆形
 *
 *	@return	嵌套圆形
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image centerImage:(UIImage *)centerImage;


/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (instancetype)mr_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

/**
 *	@brief	快速生成二维码
 *
 *	@param 	inputData 	数据
 *	@param 	size 	尺寸
 *
 *	@return	二维码
 */
+ (instancetype)mr_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size
;

/**
 *	@brief	快速生成中间有图片的二维码
 *
 *	@param 	inputData 	数据
 *	@param 	centerImage 	中间图片
 *	@param 	size 	尺寸
 *
 *	@return	二维码
 */
+ (instancetype)mr_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size
;

/**
 *	@brief	快速生成一张黑白图片
 *
 *	@param 	image 	图片
 *	@param 	size 	尺寸
 *
 *	@return	黑白图片
 */
+ (UIImage *)mr_createMonochromeWithOriginalImage:(UIImage *)image withSize:(CGFloat)size
;
@end
