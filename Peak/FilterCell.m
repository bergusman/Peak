//
//  FilterCell.m
//  Peak
//
//  Created by Vitaly Berg on 20/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

+ (CGFloat)height {
    return 50;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"FilterCell" bundle:nil];
}

@end
