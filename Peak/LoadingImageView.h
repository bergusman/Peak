//
//  AvatarView.h
//  TheQuestion
//
//  Created by Vitaly Berg on 22/01/15.
//  Copyright (c) 2015 TheQuestion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingImageView : UIView

@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setImageWithURL:(NSURL *)url;

@end
