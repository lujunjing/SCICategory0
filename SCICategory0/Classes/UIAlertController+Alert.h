//
//  UIAlertController+Alert.h
//  SummerIsComingA
//
//  Created by apple on 2019/9/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionResponse)(NSInteger clickIndex);

@interface UIAlertController (Alert)


+ (void)alertWithViewController:(UIViewController *)viewController preferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles response:(ActionResponse)response;


/// UIAlertController展示
/// @param viewController 展示的VC
/// @param preferredStyle alert样式
/// @param title 标题
/// @param message 内容
/// @param messageaAttribute 内容属性
/// @param actionTitles 按钮文字(默认两个,左取消、右确定)
/// @param actionColors 按钮文字颜色(默认两个)
/// @param response response
+ (void)alertWithViewController:(UIViewController *)viewController
                 preferredStyle:(UIAlertControllerStyle)preferredStyle
                          title:(NSString *)title
                        message:(NSString *)message
              messageaAttribute:(NSMutableAttributedString *)messageaAttribute
                   actionTitles:(NSArray *)actionTitles
                   actionColors:(NSArray *)actionColors
                       response:(ActionResponse)response;

@end

NS_ASSUME_NONNULL_END
