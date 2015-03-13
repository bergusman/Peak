//
//  PlaceCardCell.h
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;
@protocol PlaceCardCellDelegate;

@interface PlaceCardCell : UICollectionViewCell

- (void)fillWithPlace:(Place *)place;

+ (UINib *)nib;

@end

@protocol PlaceCardCellDelegate <NSObject>

- (void)placeCardCellDidTouchGetDirection:(PlaceCardCell *)cell;
- (void)placeCardCellDidTouchAddToFavorites:(PlaceCardCell *)cell;

@end