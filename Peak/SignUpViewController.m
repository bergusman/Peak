//
//  SignUpViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "SignUpViewController.h"

#import "UIWindow+Helper.h"

#import "AppDelegate.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fieldsTopConstraint;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation SignUpViewController

#pragma mark - Setups

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Content

- (void)signup {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *name = self.nameTextField.text;
    
    [[AppDelegate shared].peak signupWithEmail:email password:password name:name completion:^(NSError *error) {
    }];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    self.titleTopConstraint.constant = VALUE_FROM(70, -60, 30, 72);
    self.fieldsTopConstraint.constant = VALUE_FROM(144, 20, 100, 152);
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    self.titleTopConstraint.constant = VALUE_FROM(70, 58, 74, 132);
    self.fieldsTopConstraint.constant = VALUE_FROM(144, 140, 180, 220);
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Actions

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)signUpButtonTouchUpInside:(id)sender {
    [self signup];
    //[self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logInButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.rePasswordTextField becomeFirstResponder];
    } else if (textField == self.rePasswordTextField) {
        [self signup];
    }
    return YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupKeyboardNotifications];
    
    self.titleTopConstraint.constant = VALUE_FROM(70, 58, 74, 132);
    self.fieldsTopConstraint.constant = VALUE_FROM(144, 140, 180, 220);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
