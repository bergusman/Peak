//
//  FilterCell.h
//  Peak
//
//  Created by Vitaly Berg on 20/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

+ (CGFloat)height;

+ (UINib *)nib;

@end
