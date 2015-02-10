//
//  UIImage+Helper.h
//  QRPayments
//
//  Created by Vitaly Berg on 27/07/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor;

@end
