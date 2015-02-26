//
//  UIWindow+Helper.h
//  Peak
//
//  Created by Vitaly Berg on 25/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VALUE_FROM(v1, v2, v3, v4) ([UIWindow valueFrom:(v1) :(v2) :(v3) :(v4)])

@interface UIWindow (Helper)

+ (UIWindow *)applicationWindow;

+ (BOOL)isiPhone4;
+ (BOOL)isiPhone5;
+ (BOOL)isiPhone6;
+ (BOOL)isiPhone6plus;

+ (CGFloat)valueFrom:(CGFloat)v1 :(CGFloat)v2 :(CGFloat)v3 :(CGFloat)v4;

@end
