//
//  VerticalSeparatorView.m
//  TheQuestion
//
//  Created by Vitaly Berg on 19/01/15.
//  Copyright (c) 2015 TheQuestion. All rights reserved.
//

#import "VerticalSeparatorView.h"

@implementation VerticalSeparatorView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(1 / [UIScreen mainScreen].scale, UIViewNoIntrinsicMetric);
}

@end
