//
//  AvatarView.m
//  TheQuestion
//
//  Created by Vitaly Berg on 22/01/15.
//  Copyright (c) 2015 TheQuestion. All rights reserved.
//

#import "LoadingImageView.h"

#import <SDWebImage/SDWebImageManager.h>

@interface LoadingImageView ()

@property (strong, nonatomic) id<SDWebImageOperation> operation;

@end

@implementation LoadingImageView

- (void)dealloc {
    [self.operation cancel];
}

- (void)setImageWithURL:(NSURL *)url {
    [self.operation cancel];
    
    if (!self.contentView) {
        self.contentView = self.imageView;
    }
    
    self.contentView.alpha = 0;
    self.placeholderView.alpha = 1;
    
    __weak typeof(self) wself = self;
    
    self.operation = [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!wself) {
            return;
        }
        
        if (image) {
            wself.imageView.image = image;
            
            if (cacheType == SDImageCacheTypeNone) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.25 animations:^{
                        wself.contentView.alpha = 1;
                    } completion:^(BOOL finished) {
                        wself.placeholderView.alpha = 0;
                    }];
                });
            } else {
                wself.placeholderView.alpha = 0;
                wself.contentView.alpha = 1;
            }
        }
    }];
}

@end
