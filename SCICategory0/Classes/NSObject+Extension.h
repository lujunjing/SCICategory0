//
//  NSObject+Extension.h
//  SummerIsComingA
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

- (BOOL)pushLoginViewController;

- (BOOL)pushLoginViewControllerWithTitle:(NSString *)title contentText:(NSString *)contentText;

- (void)pushViewControllerWithViewController:(UIViewController *)viewController;
- (void)presentViewControllerWithViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
