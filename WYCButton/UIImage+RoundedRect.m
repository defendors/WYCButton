//
//  UIImage+RoundedRect.m
//
//  Created by WD_王宇超 on 16/2/22.
//

#import "UIImage+RoundedRect.h"

@implementation UIImage(RoundedRect)
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius {
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (cornerRadius < 0)
        cornerRadius = 0;
    else if (cornerRadius > MIN(w, h))
        cornerRadius = MIN(w, h) / 2.;
    
    UIImage *image = nil;
    CGRect imageFrame = CGRectMake(0., 0., w, h);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:cornerRadius] addClip];
    [self drawInRect:imageFrame];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
	//设置长宽
	CGRect rect = CGRectMake(0.0f, 0.0f, 5.0f, 5.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}
//生成圆角UIIamge 的方法
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius
{
	UIImage *original = self;
	CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
	// 开始一个Image的上下文
	UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
	// 添加圆角
	[[UIBezierPath bezierPathWithRoundedRect:frame
								cornerRadius:cornerRadius] addClip];
	// 绘制图片
	[original drawInRect:frame];
	// 接受绘制成功的图片
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
	//绘制图片
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
	
	//生成有颜色的图片
	//绘制图片
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	// 添加圆角
	[[UIBezierPath bezierPathWithRoundedRect:rect
								cornerRadius:cornerRadius] addClip];
	// 绘制图片
	[image drawInRect:rect];
	// 接受绘制成功的图片
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resultImage;
	
}




@end
