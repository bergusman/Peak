//
//  LogInViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "LogInViewController.h"

#import "SignUpViewController.h"

#import "UIWindow+Helper.h"

#import "AppDelegate.h"

// TODO: animate blue border of text fields

@interface LogInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fieldsTopConstraint;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

#pragma mark - Setups

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Content

- (void)logIn {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [[AppDelegate shared].peak loginWithEmail:email password:password completion:^(NSError *error) {
        
    }];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    self.titleTopConstraint.constant = VALUE_FROM(-50, 44, 125, 174);
    self.fieldsTopConstraint.constant = VALUE_FROM(36, 114, 206, 255);
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    self.titleTopConstraint.constant = VALUE_FROM(70, 104, 125, 174);
    self.fieldsTopConstraint.constant = VALUE_FROM(144, 185, 206, 255);
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Actions

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)logInButtonTouchUpInside:(id)sender {
    [self logIn];
}

- (IBAction)signUpButtonTouchUpInside:(id)sender {
    SignUpViewController *signUpVC = [[SignUpViewController alloc] init];
    [self presentViewController:signUpVC animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self logIn];
    }
    return YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupKeyboardNotifications];
    
    self.titleTopConstraint.constant = VALUE_FROM(70, 104, 125, 174);
    self.fieldsTopConstraint.constant = VALUE_FROM(144, 185, 206, 255);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
