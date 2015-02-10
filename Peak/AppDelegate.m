//
//  AppDelegate.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "LogInViewController.h"

#import "UIColor+Helper.h"
#import "UIImage+Helper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = mainNC;
    
    [mainNC.navigationBar setBackgroundImage:[UIImage imageWithSize:CGSizeMake(1, 64) color:RGB(40, 44, 48)] forBarMetrics:UIBarMetricsDefault];
    //[mainNC.navigationBar setShadowImage:[UIImage imageWithSize:CGSizeMake(320, 1) color:RGB(54, 254, 154)]];
    
    mainNC.navigationBar.barStyle = UIBarStyleBlack;
    
    LogInViewController *logInVC = [[LogInViewController alloc] init];
    [mainNC presentViewController:logInVC animated:NO completion:nil];
    
    //http://graph.facebook.com/SashaGrey/picture?type=large
    
    return YES;
}

@end
