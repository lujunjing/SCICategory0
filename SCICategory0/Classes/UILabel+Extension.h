//
//  UILabel+Extension.h
//  SummerIsComingA
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)
 
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)labelWithTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)labelWithTitle:(NSString *)title
    textColor:(UIColor *)textColor
         font:(UIFont *)font
textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter backgroundColor:(UIColor *)backgroundColor;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

+ (NSAttributedString *)labelDefaultAttributedText:(NSString *)text;

+ (CGFloat)labelHeightFormContentString:(NSString *)str andLineSpacing:(CGFloat)lineSpace andFontOfSize:(CGFloat)fontSize andContentWidth:(CGFloat)contentWidth;

+ (CGFloat)labelWidthFormContentString:(NSString *)str andLineSpacing:(CGFloat)lineSpace andFontOfSize:(CGFloat)fontSize andContentHeight:(CGFloat)contentHeight;

@end

NS_ASSUME_NONNULL_END
