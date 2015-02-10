//
//  CommentCell.m
//  Peak
//
//  Created by Vitaly Berg on 10/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "CommentCell.h"

#import "LoadingImageView.h"

@interface CommentCell ()

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;

@end

@implementation CommentCell

- (void)fill {
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
}

+ (CGFloat)height {
    return 140;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"CommentCell" bundle:nil];
}

@end
