//
//  UIView+Extension.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha cornerRadius:(CGFloat)cornerRadius {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    view.alpha = alpha;
    if (cornerRadius != 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    return view;
}

#pragma mark - location of view

- (void)setMinX:(CGFloat)minX {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
}

- (void)setMinY:(CGFloat)minY {
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}

- (void)setMidX:(CGFloat)midX {
    CGPoint center = self.center;
    center.x = midX;
    self.center = center;
}

- (void)setMidY:(CGFloat)midY {
    CGPoint center = self.center;
    center.y = midY;
    self.center = center;
}

- (void)setMaxX:(CGFloat)maxX {
    self.minX = maxX - self.width;
}

- (void)setMaxY:(CGFloat)maxY {
    self.minY = maxY - self.height;
}

- (void)setToSuperViewLeft:(CGFloat)toSuperViewLeft {
    self.minX = toSuperViewLeft;
}

- (void)setToSuperViewRight:(CGFloat)toSuperViewRight {
    UIView *view = self.superview;
    if (!view) {
        view = [UIApplication sharedApplication].windows[0];
    }
    self.maxX = self.superview.width - toSuperViewRight;
}

- (void)setToSuperViewTop:(CGFloat)toSuperViewTop {
    self.minY = toSuperViewTop;
}

- (void)setToSuperViewBottom:(CGFloat)toSuperViewBottom {
    UIView *view = self.superview;
    if (!view) {
        view = [UIApplication sharedApplication].windows[0];
    }
    self.maxY = self.superview.height - toSuperViewBottom;
}

- (void)setLeftView:(UIView *)leftView {
    [self setLeftToView:leftView withMargin:0];
}

- (void)setRightView:(UIView *)rightView {
    [self setRightToView:rightView withMargin:0];
}

- (void)setTopView:(UIView *)topView {
    [self setTopToView:topView withMargin:0];
}

- (void)setBottomView:(UIView *)bottomView {
    [self setBottomToView:bottomView withMargin:0];
}

- (CGFloat)minX {
    return self.frame.origin.x;
}

- (CGFloat)minY {
    return self.frame.origin.y;
}

- (CGFloat)midX {
    return self.center.x;
}

- (CGFloat)midY {
    return self.center.y;
}

- (CGFloat)maxX {
    return self.minX + self.width;
}

- (CGFloat)maxY {
    return self.minY + self.height;
}

- (CGFloat)toSuperViewLeft {
    return self.minX;
}

- (CGFloat)toSuperViewRight {
    UIView *view = self.superview;
    if (!view) {
        view = [UIApplication sharedApplication].windows[0];
    }
    return view.width - self.maxX;

}

- (CGFloat)toSuperViewTop {
    return self.minY;
}

- (CGFloat)toSuperViewBottom {
    UIView *view = self.superview;
    if (!view) {
        view = [UIApplication sharedApplication].windows[0];
    }
    return self.superview.height - self.maxY;
}

- (UIView *)leftView {return nil;}

- (UIView *)rightView {return nil;}

- (UIView *)topView {return nil;}

- (UIView *)bottomView {return nil;}

#pragma mark - size of view

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSide:(CGFloat)side {
    self.height = side;
    self.width = side;
}

- (void)setWidthWithLockArea:(CGFloat)widthWithLockArea {
    self.height = self.area / widthWithLockArea;
    self.width = self.widthWithLockArea;
}

- (void)setHeightWithLockArea:(CGFloat)heightWithLockArea {
    self.width = self.area / heightWithLockArea;
    self.height = heightWithLockArea;
}

- (void)setWidthWithLockCircumference:(CGFloat)widthWithLockCircumference {
    self.height = self.circumference / 2 - widthWithLockCircumference;
    self.width = widthWithLockCircumference;
}

- (void)setHeightWithLockCircumference:(CGFloat)heightWithLockCircumference {
    self.width = self.circumference / 2 - heightWithLockCircumference;
    self.height = heightWithLockCircumference;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)side {
    return (self.height + self.width) * 0.5;
}

- (CGFloat)area {
    return self.width * self.height;
}

- (CGFloat)circumference {
    return 2 * (self.width + self.height);
}

- (CGFloat)widthWithLockArea {
    return self.width;
}

- (CGFloat)heightWithLockArea {
    return self.height;
}

- (CGFloat)widthWithLockCircumference {
    return self.width;
}

- (CGFloat)heightWithLockCircumference {
    return self.height;
}

#pragma mark - struct of view

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGSize)halfSize {
    return CGSizeMake(self.width * 0.5, self.height * 0.5);
}

- (CGPoint)midPoint {
    return CGPointMake(self.width * 0.5, self.height * 0.5);
}

#pragma mark - method with other view

- (void)setLeftInView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.minX = temp.minX + margin;
}

- (void)setLeftToView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.minX = temp.maxX + margin;
}

- (void)setRightInView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.maxX = temp.maxX - margin;
}

- (void)setRightToView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.maxX = temp.minX - margin;
}

- (void)setTopInView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.minY = temp.minY + margin;
}

- (void)setTopToView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.minY = temp.maxY + margin;
}

- (void)setBottomInView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.maxY = temp.maxY - margin;
}

- (void)setBottomToView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect targetFrame = view.frame;
    targetFrame = [view.superview convertRect:targetFrame toView:self.superview];
    UIView *temp = [[UIView alloc] initWithFrame:targetFrame];
    self.maxY = temp.minY - margin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end


@implementation UIView (Layer)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

@end
