//
//  PlaceCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

+ (CGFloat)height {
    return 68;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"PlaceCell" bundle:nil];
}

@end
