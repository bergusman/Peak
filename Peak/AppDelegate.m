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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = mainNC;
    
    LogInViewController *logInVC = [[LogInViewController alloc] init];
    [mainNC presentViewController:logInVC animated:NO completion:nil];
    
    return YES;
}

@end
