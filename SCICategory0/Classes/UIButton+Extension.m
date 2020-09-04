//
//  UIButton+Extension.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
#define defaultInterval 0.0003  //默认时间间隔,不能太长，以免影响系统拍照等功能

@interface UIButton ()
//YES 忽略点击事件   NO 允许点击事件
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (Extension)

static const char *UIControl_eventTimeInterval   = "UIControl_eventTimeInterval";
static const char *UIControl_enventIsIgnoreEvent = "UIControl_enventIsIgnoreEvent";

static char topNameKey;
static char leftNameKey;
static char bottomNameKey;
static char rightNameKey;


+ (void)load {
    //Method swizzing
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //根据selector查找method
        SEL selA = @selector(sendAction:to:forEvent:);
        Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        
        SEL selB = @selector(new_sendAction:to:forEvent:);
        Method customMethod = class_getInstanceMethod(self, @selector(new_sendAction:to:forEvent:));
        
        //这个方法的作用是，给类添加一个新的方法和该方法的具体实现
        /*
         class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp, const char * _Nullable types)

         Class cls: 将要给添加方法的类，传的类型 ［类名  class］
         SEL name: 将要添加的方法名，传的类型   @selector(方法名)
         IMP imp：实现这个方法的函数 ，传的类型   1，C语言写法：（IMP）方法名    2，OC的写法：class_getMethodImplementation(self,@selector(方法名：))
         const char *types：表示我们要添加的方法的返回值和参数

         */
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

#pragma -解决按钮重复点击问题
- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if(self.clickIntervalTime <= 0) self.clickIntervalTime = defaultInterval;
    if(self.isIgnoreEvent) {
        //忽略点击事件
        return;
    }else {
        //允许点击事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickIntervalTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
        });
    }
    
    //忽略点击事件
    self.isIgnoreEvent = YES;
    // 这里看上去会陷入递归调用死循环，但在运行期此方法是和sendAction:to:forEvent:互换的，
    // 相当于执行sendAction:to:forEvent:方法，所以并不会陷入死循环。
    [self new_sendAction:action to:target forEvent:event];
}

#pragma mark - runtime动态绑定属性
- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, UIControl_enventIsIgnoreEvent) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, UIControl_enventIsIgnoreEvent, @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)clickIntervalTime {
    return [objc_getAssociatedObject(self, UIControl_eventTimeInterval) doubleValue];
}

- (void)setClickIntervalTime:(NSTimeInterval)clickIntervalTime {
    objc_setAssociatedObject(self, UIControl_eventTimeInterval, @(clickIntervalTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 扩大按钮点击范围
- (void)setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey,   [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &leftNameKey,  [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &bottomNameKey,[NSNumber numberWithFloat:size], OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_ASSIGN);
}

- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right {
    objc_setAssociatedObject(self, &topNameKey,   [NSNumber numberWithFloat:top],   OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &leftNameKey,  [NSNumber numberWithFloat:left],  OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &bottomNameKey,[NSNumber numberWithFloat:bottom],OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_ASSIGN);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge    = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge  = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge   = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x    - leftEdge.floatValue,
                          self.bounds.origin.y    - topEdge.floatValue,
                          self.bounds.size.width  + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
        
    }else{
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

#pragma mark - 按钮初始化方法
+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action image:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font image:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    if (!action) {
        button.userInteractionEnabled = NO;
    } else {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled = YES;
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = 1;
    return button;
}

+ (UIButton *)buttonBackgroundColor:(UIColor *)backgroundColor target:(id)target action:(_Nullable SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = 1;
    return button;
}

+ (UIButton *)buttonEnableWithTarget:(id)target action:(_Nullable SEL)action title:(NSString *)title titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)buttonDisabelWithTarget:(id)target action:(_Nullable SEL)action title:(NSString *)title titleLabelFont:(UIFont *)font cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}

@end
