//
//  UIColor+CLExtension.h
//  Example_OC
//
//  Created by light on 2018/5/3.
//  Copyright © 2018年 light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CLExtension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
