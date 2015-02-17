//
//  PhotoCell.h
//  Peak
//
//  Created by Vitaly Berg on 17/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoadingImageView.h"

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet LoadingImageView *loadingImageView;

- (void)fill;

+ (UINib *)nib;

@end
