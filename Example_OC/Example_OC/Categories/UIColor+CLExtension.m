//
//  UIColor+CLExtension.m
//  Example_OC
//
//  Created by light on 2018/5/3.
//  Copyright © 2018年 light. All rights reserved.
//



@implementation UIColor (CLExtension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString{
    return [UIColor colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    UIColor *color;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        color = [self colorWithHex:hexValue alpha:alpha];
    } else {
        // invalid hex string
        color = [self blackColor];
    }
    return color;
}


@end
