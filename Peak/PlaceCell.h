//
//  PlaceCell.h
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;

@interface PlaceCell : UITableViewCell

- (void)fillWithPlace:(Place *)place;
+ (CGFloat)height;

+ (UINib *)nib;

@end
