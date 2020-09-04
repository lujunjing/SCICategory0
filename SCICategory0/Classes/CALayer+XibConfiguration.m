//
//  CALayer+XibConfiguration.m
//  SummerIsComingA
//
//  Created by apple on 2019/9/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

- (void)setBorderUIColor:(UIColor *)borderUIColor {
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
