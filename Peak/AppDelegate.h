//
//  AppDelegate.h
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Peak.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Peak *peak;

+ (AppDelegate *)shared;

@end

