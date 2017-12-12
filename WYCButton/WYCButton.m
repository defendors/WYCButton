//
//  WYCButton.m
//  WYCButton
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UIImage (WYCButtonImage)
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
@end
@implementation UIImage(WYCButtonImage)
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
	CGFloat temp_cornerRadius =cornerRadius;
	CGFloat w = size.width;
	CGFloat h = size.height;
	if (temp_cornerRadius < 0)
		temp_cornerRadius = 0;
	else if (temp_cornerRadius > MIN(w, h))
		temp_cornerRadius = MIN(w, h) / 2.;
	
	//开启图形上下文
	if (size.width == 0 || size.height == 0) {
		return nil;
	}
	UIGraphicsBeginImageContext(size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	
	//绘制颜色区域
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
	[path fill];
	//从图形上下文获取图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	//关闭图形上下文
	UIGraphicsEndImageContext();
	return newImage;
}

@end


#import "WYCButton.h"
@interface WYCButton()
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;
@end
@implementation WYCButton
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */

{
	CGSize imageSize;
	UIColor* normalBackgroundImageColor;
	UIImage* normalBackgroundImage;
	UIColor* selectedBackgroundImageColor;
	UIImage* selectedBackgroundImage;
	UIColor* disableBackgroundImageColor;
	UIImage* disableBackgroundImage;
}
@synthesize backgroundImageCornerRadius = _backgroundImageCornerRadius;

#pragma mark life cycle
//+(instancetype)buttonWithType:(UIButtonType)buttonType
//{
//	LJDCommonButton* button;
//	button = [super buttonWithType:buttonType];
//	//    [button setBackgroundColor:[UIColor colorWithRed:9.00/255.00 green:143.00/255.00 blue:211.00/255.00 alpha:1]];
////	button.layer.cornerRadius = 6.0;
//	return button;
//}
-(void)setBackgroundImageCornerRadius:(CGFloat)backgroundImageCornerRadius{
	_backgroundImageCornerRadius = backgroundImageCornerRadius;
	self.layer.cornerRadius = _backgroundImageCornerRadius;
}
-(CGFloat)backgroundImageCornerRadius{
	return _backgroundImageCornerRadius;
}
- (void)layoutSubviews{
	[super layoutSubviews];
	//把图片的绘制转移至layoutSubviews时调用
	
	CGFloat view_W = self.frame.size.width;
	CGFloat view_H = self.frame.size.height;
	if (0 != view_H
		&&
		0 != view_W) {
		
		if (imageSize.height != view_H
			||
			imageSize.width != view_W) {
			imageSize.height = view_H;
			imageSize.width = view_W;
			
			[self handleBackgroundImage];
			
		}
		
	}
	
	
}

#pragma mark public method
-(void)startTimeCount{
	self.enabled = NO;
	__weak typeof(self)weakSelf=self;
	__block NSInteger count = 0;
	
	// 获得队列
	dispatch_queue_t queue = dispatch_get_main_queue();
	
	// 创建一个定时器(dispatch_source_t本质还是个OC对象)
	self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	// 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
	// GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
	// 何时开始执行第一个任务
	// dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
	dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
	uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
	dispatch_source_set_timer(self.timer, start, interval, 0);
	
	// 设置回调
	dispatch_source_set_event_handler(self.timer, ^{
		_buttonBlock(weakSelf,_totalTime,_totalTime - count);
		count++;
		if (count >= _totalTime + 1) {
			// 取消定时器
			dispatch_cancel(self.timer);
			self.timer = nil;
			self.enabled = YES;
		}
	});
	
	// 启动定时器
	dispatch_resume(self.timer);
	
}
-(void)stopTimeCount{
	dispatch_resume(self.timer);
	self.timer = nil;
	self.enabled = YES;
	
}

-(void)setNormalTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
	[self setTitleColor:normalColor forState:UIControlStateNormal];
	[self setTitleColor:selectedColor forState:UIControlStateHighlighted];
	[self setTitleColor:selectedColor forState:UIControlStateSelected | UIControlStateHighlighted];
	[self setTitleColor:selectedColor forState:UIControlStateSelected];
}
-(void)setNormalTitleColor:(UIColor*)normalColor selectedColor:(UIColor*)selectedColor disableTitleColor:(UIColor*)disableTitleColor{
	[self setTitleColor:normalColor forState:UIControlStateNormal];
	[self setTitleColor:selectedColor forState:UIControlStateHighlighted];
	[self setTitleColor:selectedColor forState:UIControlStateSelected];
	[self setTitleColor:selectedColor forState:UIControlStateSelected | UIControlStateHighlighted];
	[self setTitleColor:disableTitleColor forState:UIControlStateDisabled];
}
-(void)setNormalBackGroundColor:(UIColor*)normalColor setlectedColor:(UIColor*)selectedColor
{
	normalBackgroundImageColor = normalColor;
	selectedBackgroundImageColor = selectedColor;
	if (0 != self.frame.size.width
		&&
		0 != self.frame.size.height) {
		[self handleBackgroundImage];
	}
}
-(void)setNormalBackGroundColor:(UIColor*)normalColor setlectedColor:(UIColor*)selectedColor disableColor:(UIColor*)disableColor{
	normalBackgroundImageColor = normalColor;
	selectedBackgroundImageColor = selectedColor;
	disableBackgroundImageColor = disableColor;
	
	if (0 != self.frame.size.width
		&&
		0 != self.frame.size.height) {
		[self handleBackgroundImage];
	}
}
-(void)setNormalTitleText:(NSString*)normalString selectedString:(NSString*)selectedString
{
	[self setTitle:normalString forState:UIControlStateNormal];
	[self setTitle:selectedString forState:UIControlStateSelected];
	[self setTitle:selectedString forState:UIControlStateSelected | UIControlStateHighlighted];
	[self setTitle:selectedString forState:UIControlStateHighlighted];
}
-(void)setNormalTitleText:(NSString*)normalString selectedString:(NSString*)selectedString disableString:(NSString*)disableString{
	[self setTitle:normalString forState:UIControlStateNormal];
	[self setTitle:selectedString forState:UIControlStateSelected];
	[self setTitle:selectedString forState:UIControlStateHighlighted];
	[self setTitle:selectedString forState:UIControlStateSelected | UIControlStateHighlighted];
	[self setTitle:disableString forState:UIControlStateDisabled];
}
#pragma mark private method
-(void)LJDCommonSetBackgroundImage:(UIImage *)image forState:(UIControlState)state{
	[self setBackgroundImage:image forState:state];
}
- (void)handleBackgroundImage{
	if (YES == _isCycle) {
		_backgroundImageCornerRadius = imageSize.width > imageSize.height ? imageSize.width / 2.00 : imageSize.height / 2.00;
	}
	if (normalBackgroundImageColor) {
		normalBackgroundImage = [UIImage createImageColor:normalBackgroundImageColor size:imageSize cornerRadius:_backgroundImageCornerRadius];
	}else{
		normalBackgroundImage = nil;
	}
	[self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
	
	if (selectedBackgroundImageColor) {

		selectedBackgroundImage = [UIImage createImageColor:selectedBackgroundImageColor size:imageSize cornerRadius:_backgroundImageCornerRadius];
	}else{
		selectedBackgroundImage = nil;
	}
	[self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
	[self setBackgroundImage:selectedBackgroundImage forState:UIControlStateHighlighted];
	[self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected | UIControlStateHighlighted];
	
	if (disableBackgroundImageColor) {
		disableBackgroundImage = [UIImage createImageColor:disableBackgroundImageColor size:imageSize cornerRadius:_backgroundImageCornerRadius];
	}else{
		disableBackgroundImage = nil;
	}
	[self setBackgroundImage:disableBackgroundImage forState:UIControlStateDisabled];
	
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


