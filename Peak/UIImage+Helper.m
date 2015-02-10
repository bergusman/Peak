//
//  UIImage+Helper.m
//  QRPayments
//
//  Created by Vitaly Berg on 27/07/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [color setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor {
    UIGraphicsBeginImageContextWithOptions([path bounds].size, NO, [UIScreen mainScreen].scale);
    
    if (fillColor) {
        [fillColor setFill];
        [path fill];
    }
    
    if (strokeColor) {
        [strokeColor setStroke];
        [path stroke];
    }
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

@end
