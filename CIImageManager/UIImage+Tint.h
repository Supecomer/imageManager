//
//  UIImage+Tint.h
//  CIImageManager
//
//  Created by ciome on 2017/8/24.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import <UIKit/UIKit.h>

//Apple额外定义的枚举
//R: premultiplied result, 表示混合结果
//S: Source, 表示源颜色(Sa对应透明度值: 0.0-1.0)
//D: destination colors with alpha, 表示带透明度的目标颜色(Da对应透明度值: 0.0-1.0)

/*
 kCGBlendModeNormal: 正常；也是默认的模式。前景图会覆盖背景图
 kCGBlendModeMultiply: 正片叠底；混合了前景和背景的颜色，最终颜色比原先的都暗
 kCGBlendModeScreen: 滤色；把前景和背景图的颜色先反过来，然后混合
 kCGBlendModeOverlay: 覆盖；能保留灰度信息，结合kCGBlendModeSaturation能保留透明度信息，在imageWithBlendMode方法中两次执行drawInRect方法实现我们基本需求
 kCGBlendModeDarken: 变暗
 kCGBlendModeLighten: 变亮
 kCGBlendModeColorDodge: 颜色变淡
 kCGBlendModeColorBurn: 颜色加深
 kCGBlendModeSoftLight: 柔光
 kCGBlendModeHardLight: 强光
 kCGBlendModeDifference: 插值
 kCGBlendModeExclusion: 排除
 kCGBlendModeHue: 色调
 kCGBlendModeSaturation: 饱和度
 kCGBlendModeColor: 颜色
 kCGBlendModeLuminosity: 亮度
 kCGBlendModeClear: R = 0
 kCGBlendModeCopy: R = S
 kCGBlendModeSourceIn: R = S*Da
 kCGBlendModeSourceOut: R = S*(1 - Da)
 kCGBlendModeSourceAtop: R = S*Da + D*(1 - Sa)
 kCGBlendModeDestinationOver: R = S*(1 - Da) + D
 kCGBlendModeDestinationIn: R = D*Sa；能保留透明度信息
 kCGBlendModeDestinationOut: R = D*(1 - Sa)
 kCGBlendModeDestinationAtop: R = S*(1 - Da) + D*Sa
 kCGBlendModeXOR: R = S*(1 - Da) + D*(1 - Sa)
 kCGBlendModePlusDarker: R = MAX(0, (1 - D) + (1 - S))
 kCGBlendModePlusLighter: R = MIN(1, S + D)（最后一种混合模式
 */

@interface UIImage(CITint)

/**
 保留透明度，改变颜色

 @param tintColor color
 @return image
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

/**
 覆盖；能保留灰度信息，结合kCGBlendModeSaturation能保留透明度信息，在imageWithBlendMode方法中两次执行drawInRect方法实现我们基本需求

 @param tintColor color
 @return image
 */
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

/**
  all api

 @param tintColor color
 @param blendMode mode
 @return image
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;


@end
