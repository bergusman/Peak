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

#import "Peak.h"
#import "Logger.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Mapbox-iOS-SDK/Mapbox.h>

@interface AppDelegate () <PeakDelegate>

@end

@implementation AppDelegate

#pragma mark - Setups

- (void)setupStart {
    [Fabric with:@[CrashlyticsKit]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (void)setupPeak {
    self.peak = [[Peak alloc] initWithApiUrl:@"http://localhost:5000/api/" delegate:self];
    //self.peak = [[Peak alloc] initWithApiUrl:@"https://morning-hamlet-4204.herokuapp.com/api/" delegate:self];
    if (self.peak.state == PeakStateAuthed) {
        [self.peak updateMe];
    }
}

- (void)setupApp {
    [[RMConfiguration sharedInstance] setAccessToken:@"pk.eyJ1IjoiYmVyZ3VzbWFuIiwiYSI6IkozeVpWeTQifQ.w6OQ2fChXwExxGTWn5nmNg"];
    // Flurry here
    
    [self setupAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
}

- (void)setupAppearance {
    
}

#pragma mark - Content

- (void)showStart {
    DDLogVerbose(@"APP DELEGATE: showStart");
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = mainNC;
    
    [mainNC.navigationBar setBackgroundImage:[UIImage imageWithSize:CGSizeMake(1, 64) color:RGB(40, 44, 48)] forBarMetrics:UIBarMetricsDefault];
    //[mainNC.navigationBar setShadowImage:[UIImage imageWithSize:CGSizeMake(320, 1) color:RGB(54, 254, 154)]];
    
    mainNC.navigationBar.barStyle = UIBarStyleBlack;
    
    if (self.peak.state == PeakStateNone) {
        [self showLogin];
    }
}

- (void)showLogin {
    DDLogVerbose(@"APP DELEGATE: showLogin");
    LogInViewController *logInVC = [[LogInViewController alloc] init];
    [self.window.rootViewController presentViewController:logInVC animated:NO completion:nil];
}

- (void)showApp {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PeakDelegate

- (void)peakDidChangeState:(Peak *)peak {
    DDLogVerbose(@"APP DELEGATE: peakDidChangeState: %ld", (long)peak.state);
    if (peak.state == PeakStateAuthed) {
        [self showApp];
    } else {
        [self showLogin];
    }
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupStart];
    DDLogVerbose(@"APP DELEGATE: didFinishLaunchingWithOptions: %@", launchOptions);
    [self setupPeak];
    [self setupApp];
    [self showStart];
    return YES;
}

#pragma mark - Singleton

+ (AppDelegate *)shared {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
