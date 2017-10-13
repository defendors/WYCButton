//
//  WYCButton.h
//  WYCButton
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYCButton;
typedef void (^timerButtonTimeBlock)(WYCButton *timerBotton,NSInteger totalTime,NSInteger remainTime);
@interface WYCButton : UIButton
/**
 设置背景颜色图片的圆角半径
 */
@property(assign,nonatomic)CGFloat backgroundImageCornerRadius;

/**
 是否是圆形（如果为YES，backgroundImageCornerRadius将会设置为圆的半径，同时，layer.cornerRadius也设置为半径）
 */
@property(assign,nonatomic)BOOL isCycle;


/**
 计时模式下的总时间（秒）
 */
@property(assign,nonatomic)NSInteger totalTime;
/**
 每秒执行的block
 */
@property(strong,nonatomic)timerButtonTimeBlock buttonBlock;

/**
 开始计时模式
 */
-(void)startTimeCount;
/**
 结束计时模式
 */
-(void)stopTimeCount;

/**
 设置按钮标题文字
 
 @param normalString normal状态文字
 @param selectedString selected状态文字
 */
-(void)setNormalTitleText:(NSString*)normalString selectedString:(NSString*)selectedString;
/**
 设置按钮标题文字
 
 @param normalString normal状态文字
 @param selectedString selected状态文字
 @param disableString disable状态文字
 */
-(void)setNormalTitleText:(NSString*)normalString selectedString:(NSString*)selectedString disableString:(NSString*)disableString;
/**
 设置按钮文字颜色
 
 @param normalColor normal状态文字颜色
 @param selectedColor selected状态文字颜色
 */
-(void)setNormalTitleColor:(UIColor*)normalColor selectedColor:(UIColor*)selectedColor;
/**
 设置按钮文字颜色
 
 @param normalColor normal状态文字颜色
 @param selectedColor selected状态文字颜色
 @param disableTitleColor disable状态文字颜色
 */
-(void)setNormalTitleColor:(UIColor*)normalColor selectedColor:(UIColor*)selectedColor disableTitleColor:(UIColor*)disableTitleColor;

//设置背景颜色
/**
 设置背景颜色（实现原理：通过颜色创建image，设置为backguardImage）
 
 @param normalColor normal状态颜色
 @param selectedColor selected状态颜色
 */
-(void)setNormalBackGroundColor:(UIColor*)normalColor setlectedColor:(UIColor*)selectedColor;

/**
 设置背景颜色（实现原理：通过颜色创建image，设置为backguardImage）
 
 @param normalColor normal状态颜色
 @param selectedColor selected状态颜色
 @param disableColor disable状态颜色
 */
-(void)setNormalBackGroundColor:(UIColor*)normalColor setlectedColor:(UIColor*)selectedColor disableColor:(UIColor*)disableColor;

@end

