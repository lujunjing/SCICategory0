//
//  NSObject+Extension.m
//  SummerIsComingA
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (BOOL)pushLoginViewController {
    return YES;
//    if (kUserDefaultObjectForKey(kToken)) {
//        return YES;
//    } else {
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        AKSOFYTabBarController *tabBarVC = (AKSOFYTabBarController *)app.window.rootViewController;
//        AKSOFYNavigationController *nav = (AKSOFYNavigationController*)tabBarVC.selectedViewController;
//
//        AKSOFYLoginViewController * vc = [[AKSOFYLoginViewController alloc] init];
//        [nav pushViewController:vc animated:YES];
//        return NO;
//    }
}

- (BOOL)pushLoginViewControllerWithTitle:(NSString *)title contentText:(NSString *)contentText {
    return YES;
//    if (kUserDefaultObjectForKey(kToken)) {
//        return YES;
//    } else {
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        AKSOFYTabBarController *tabBarVC = (AKSOFYTabBarController *)app.window.rootViewController;
//        AKSOFYNavigationController *nav = (AKSOFYNavigationController*)tabBarVC.selectedViewController;
//        AKSOFYWeakSelf;
//        AKSOFYUnLoginViewController * vc = [[AKSOFYUnLoginViewController alloc] initWithTitle:title contentText:contentText handler:^{
//            AKSOFYLoginViewController *vc = [[AKSOFYLoginViewController alloc] init];
//            [weakSelf pushViewControllerWithViewController:vc];
//        }];
//        [nav pushViewController:vc animated:YES];
//        return NO;
//    }
}


- (void)pushViewControllerWithViewController:(UIViewController *)viewController {
    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    AKSOFYTabBarController *tabBarVC = (AKSOFYTabBarController *)app.window.rootViewController;
//    AKSOFYNavigationController *nav = (AKSOFYNavigationController*)tabBarVC.selectedViewController;
//    [nav pushViewController:viewController animated:YES];
    
} 

- (void)presentViewControllerWithViewController:(UIViewController *)viewController {
    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    AKSOFYTabBarController *tabBarVC = (AKSOFYTabBarController *)app.window.rootViewController;
//    AKSOFYNavigationController *nav = (AKSOFYNavigationController*)tabBarVC.selectedViewController;
//    [nav presentViewController:viewController animated:YES completion:nil];
    
}

@end
