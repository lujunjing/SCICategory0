//
//  NSURL+Extension.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NSURL+Extension.h"
#import <objc/runtime.h>

@interface NSURL ()

@end

@implementation NSURL (Extension)

+ (void)load {
    //Method swizzing
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //系统方法
        SEL selA = @selector(URLWithString:);
        Method systemMethod = class_getClassMethod([self class], selA);
        //新方法
        SEL selB = @selector(custom_URLWithString:);
        Method customMethod = class_getClassMethod([self class], selB);
        
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
        if (isAdd) {
            //添加成功->替换
            class_replaceMethod(self, selB, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //添加不成功->交换
            //添加失败了 说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(systemMethod, customMethod);
        }
    });
}

+ (instancetype)custom_URLWithString:(NSString *)urlStr{
    if(![urlStr hasPrefix:@"http"] && ![urlStr hasPrefix:@"https"])
        return nil;
    
    //注意这里不会导致死循环，因为已经进行了方法交换，所以执行[self custom_URLWithString:urlStr]时相当于执行的是[self URLWithString:urlStr]
    NSURL *url = [self custom_URLWithString:urlStr];
    if (url)
        return url;
    else
        return nil;
}

@end
