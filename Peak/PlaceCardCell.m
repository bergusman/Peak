//
//  PlaceCardCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PlaceCardCell.h"
#import "LoadingImageView.h"
#import "Place.h"

@interface PlaceCardCell ()

@property (weak, nonatomic) IBOutlet LoadingImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation PlaceCardCell

#pragma mark - Content

- (void)fillWithPlace:(Place *)place {
    [self.photoView setImageWithURL:[NSURL URLWithString:@"http://travelnoire.com/wp-content/uploads/2014/12/o-NEW-YORK-CITY-WRITER-facebook-1050x700.jpg"]];
    self.titleLabel.text = [place.title uppercaseString];
    self.detailsLabel.text = place.details;
}

#pragma mark - Nibbing

+ (UINib *)nib {
    return [UINib nibWithNibName:@"PlaceCardCell" bundle:nil];
}

@end
