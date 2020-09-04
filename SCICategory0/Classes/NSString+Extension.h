//
//  NSString+Extension.h
//  SummerIsComingA
//
//  Created by apple on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

+ (BOOL)isIDNumber:(NSString *)idNumber;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isNumberStr:(NSString*)string;

+ (BOOL)checkInputPassword:(NSString *)text;

+ (CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHeight:(CGFloat)height;

+ (CGFloat)heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

+ (NSString *)base64EncodedStringFromeString:(NSString *)string;

+ (NSString *)stringFromBase64EncodedString:(NSString *)base64EncodedString;

+ (NSDictionary *)dictFromJsonString:(NSString *)jsonString;

+ (NSString *)jsonStringFromDict:(NSDictionary *)dict;

- (NSString *)md5;

+ (NSString *)MD5Hash:(NSString *)aString;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string colorBreakWords:(NSInteger)len formalColor:(UIColor *)formalColor latterColor:(UIColor *)latterColor;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string colorBreakWords:(NSInteger)len formalColor:(UIColor *)formalColor latterColor:(UIColor *)latterColor formalFont:(UIFont *)formalFont latterFont:(UIFont *)latterFont;


+ (NSMutableAttributedString *)setButtonAttributedTitle:(NSString *)title lineBreakWords:(NSInteger)len formalColor:(UIColor *)formalColor latterColor:(UIColor *)latterColor;

+ (NSString *)getAgeWithBirthday:(NSString *)birthday;

+ (NSString *)getHexStringForData:(NSData *)data;
    
@end

NS_ASSUME_NONNULL_END
