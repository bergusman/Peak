//
//  UIWindow+Helper.m
//  Peak
//
//  Created by Vitaly Berg on 25/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "UIWindow+Helper.h"

#define EPSILON 0.000001

@implementation UIWindow (Helper)

+ (UIWindow *)applicationWindow {
    return [UIApplication sharedApplication].delegate.window;
}

+ (BOOL)isiPhone4 {
    return fabs([self applicationWindow].bounds.size.height - 480) < EPSILON;
}

+ (BOOL)isiPhone5 {
    return fabs([self applicationWindow].bounds.size.height - 568) < EPSILON;
}

+ (BOOL)isiPhone6 {
    return fabs([self applicationWindow].bounds.size.height - 667) < EPSILON;
}

+ (BOOL)isiPhone6plus {
    return fabs([self applicationWindow].bounds.size.height - 736) < EPSILON;
}

+ (CGFloat)valueFrom:(CGFloat)v1 :(CGFloat)v2 :(CGFloat)v3 :(CGFloat)v4 {
    if ([self isiPhone4]) {
        return v1;
    } else if ([self isiPhone5]) {
        return v2;
    } else if ([self isiPhone6]) {
        return v3;
    } else if ([self isiPhone6plus]) {
        return v4;
    }
    return v2;
}

@end
