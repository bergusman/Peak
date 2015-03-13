//
//  CommentCell.h
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface CommentCell : UITableViewCell

- (void)fillWithComment:(Comment *)comment;
+ (CGFloat)heightWithComment:(Comment *)comment;

- (void)fill;
+ (CGFloat)height;

+ (UINib *)nib;

@end
