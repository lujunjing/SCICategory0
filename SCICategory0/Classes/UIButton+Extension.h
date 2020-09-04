//
//  UIButton+Extension.h
//  SummerIsComingA
//
//  Created by apple on 2019/9/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

//添加属性 点击时间
@property (nonatomic, assign) NSTimeInterval clickIntervalTime;

//扩大按钮点击范围
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action image:(UIImage *)image;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font image:(UIImage *)image;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;

+ (UIButton *)buttonEnableWithTarget:(id)target action:(_Nullable SEL)action title:(NSString *)title titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonDisabelWithTarget:(id)target action:(_Nullable SEL)action title:(NSString *)title titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
