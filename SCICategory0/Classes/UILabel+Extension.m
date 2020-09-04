//
//  UILabel+Extension.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    return label;
}

+ (UILabel *)labelWithTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = textColor;
    label.font = font;
    return label;
}


+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (UILabel *)labelWithTitle:(NSString *)title
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
              textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = backgroundColor;
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignmentCenter:(BOOL)textAlignmentCenter backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = backgroundColor;
    label.layer.cornerRadius = cornerRadius;
    label.layer.masksToBounds = YES;
    return label;
}

+ (NSAttributedString *)labelAttributedText:(NSString *)text andLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    return attributeStr;
}

+ (NSAttributedString *)labelDefaultAttributedText:(NSString *)text {
    return [self labelAttributedText:text andLineSpacing:3];
}

//高度高度
+ (CGFloat)labelHeightFormContentString:(NSString *)str andLineSpacing:(CGFloat)lineSpace andFontOfSize:(CGFloat)fontSize andContentWidth:(CGFloat)contentWidth
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSMutableDictionary * attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    attribute[NSParagraphStyleAttributeName] = paragraphStyle;
    return [str boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
}

//宽度宽度
+ (CGFloat)labelWidthFormContentString:(NSString *)str andLineSpacing:(CGFloat)lineSpace andFontOfSize:(CGFloat)fontSize andContentHeight:(CGFloat)contentHeight
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSMutableDictionary * attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    attribute[NSParagraphStyleAttributeName] = paragraphStyle;
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, contentHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
}
@end
