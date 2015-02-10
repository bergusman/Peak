//
//  PlaceCardCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PlaceCardCell.h"

#import "LoadingImageView.h"

@interface PlaceCardCell ()

@property (weak, nonatomic) IBOutlet LoadingImageView *photoView;

@end

@implementation PlaceCardCell

- (void)fill {
    [self.photoView setImageWithURL:[NSURL URLWithString:@"http://travelnoire.com/wp-content/uploads/2014/12/o-NEW-YORK-CITY-WRITER-facebook-1050x700.jpg"]];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"PlaceCardCell" bundle:nil];
}

@end
