//
//  HeaderCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

+ (CGFloat)height {
    return 40;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"HeaderCell" bundle:nil];
}

@end
