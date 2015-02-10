//
//  HorizontalSeparatorView.m
//  TheQuestion
//
//  Created by Vitaly Berg on 19/01/15.
//  Copyright (c) 2015 TheQuestion. All rights reserved.
//

#import "HorizontalSeparatorView.h"

@implementation HorizontalSeparatorView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 1 / [UIScreen mainScreen].scale);
}

@end
