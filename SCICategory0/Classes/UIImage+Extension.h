//
//  UIImage+Extension.h
//  SummerIsComingA
//
//  Created by apple on 2019/12/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
   
//生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)string size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
