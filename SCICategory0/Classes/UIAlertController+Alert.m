//
//  UIAlertController+Alert.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIAlertController+Alert.h"

@implementation UIAlertController (Alert)

+ (void)alertWithViewController:(UIViewController *)viewController preferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles response:(ActionResponse)response {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    NSUInteger index = 0;
    for (NSString *actionTitle in actionTitles) {
        [alertController addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (response) {
                response(index);
            }
        }]];
        index++;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alertController animated:YES completion:^{
            
        }];
    });
    
}


+ (void)alertWithViewController:(UIViewController *)viewController
                 preferredStyle:(UIAlertControllerStyle)preferredStyle
                          title:(NSString *)title
                        message:(NSString *)message
              messageaAttribute:(NSMutableAttributedString *)messageaAttribute
                   actionTitles:(NSArray *)actionTitles
                   actionColors:(NSArray *)actionColors
                       response:(ActionResponse)response {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:preferredStyle];
    
    //标题/内容
    [alertController setValue:messageaAttribute forKey:@"attributedMessage"];
    
    //alertAction
    if(actionTitles.count>=1){
        //设置按钮标题
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitles[0] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (response) {
                response(0);
            }
            //            [viewController.navigationController popViewControllerAnimated:YES];
        }];
        //设置按钮标题颜色
        [action1 setValue:actionColors[0] forKey:@"titleTextColor"];
        [alertController addAction:action1];
    }
    if(actionTitles.count>=2){
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionTitles[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (response) {
                response(1);
            }
        }];
        [action2 setValue:actionColors[1] forKey:@"titleTextColor"];
        [alertController addAction:action2];
    }
    //放到主线程弹出，否则会延时
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alertController
                                     animated:YES
                                   completion:^{
            
        }];
    });
}
@end
