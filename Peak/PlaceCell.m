//
//  PlaceCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PlaceCell.h"

#import "Place.h"

@interface PlaceCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@end

@implementation PlaceCell

#pragma mark - Content

- (void)fillWithPlace:(Place *)place {
    self.titleLabel.text = [place.title uppercaseString];
}

+ (CGFloat)height {
    return 68;
}

#pragma mark - Nibbing

+ (UINib *)nib {
    return [UINib nibWithNibName:@"PlaceCell" bundle:nil];
}

@end
