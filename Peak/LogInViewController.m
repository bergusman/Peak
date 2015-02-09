//
//  LogInViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "LogInViewController.h"

#import "SignUpViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

#pragma mark - Actions

- (IBAction)logInButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpButtonTouchUpInside:(id)sender {
    SignUpViewController *signUpVC = [[SignUpViewController alloc] init];
    [self presentViewController:signUpVC animated:YES completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

@end
