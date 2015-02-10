//
//  PlaceCell.h
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (CGFloat)height;

+ (UINib *)nib;

@end
