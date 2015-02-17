//
//  PhotoCell.m
//  Peak
//
//  Created by Vitaly Berg on 17/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)fill {
    [self.loadingImageView setImageWithURL:[NSURL URLWithString:@"http://travelnoire.com/wp-content/uploads/2014/12/o-NEW-YORK-CITY-WRITER-facebook-1050x700.jpg"]];
}

+ (UINib *)nib {
    
    return [UINib nibWithNibName:@"PhotoCell" bundle:nil];
}

@end
