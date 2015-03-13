//
//  EditProfileViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "EditProfileViewController.h"

#import "LoadingImageView.h"

#import "UIImage+Helper.h"

#import "AppDelegate.h"

#define NULL_TO_EMPTY(str) ((str) ?: @"")

@interface EditProfileViewController () <UITextFieldDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation EditProfileViewController

#pragma mark - Setups

- (void)setupAvatarButton {
    UIImage *bg = [UIImage imageWithSize:CGSizeMake(6, 6) color:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
    bg = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.avatarButton setBackgroundImage:bg forState:UIControlStateHighlighted];
}

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Content

- (void)fillProfile {
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
    
    User *me = [AppDelegate shared].peak.me;
    
    self.nameLabel.text = me.name;
    
    self.nameTextField.text = me.name;
    self.emailTextField.text = me.email;
    self.locationTextField.text = me.location;
}

- (void)tryCancel {
    if ([self hasChanges]) {
        [self confirmCancel];
    } else {
        [self cancel];
    }
}

- (void)confirmCancel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"You have profile canges" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action;
    action = [UIAlertAction actionWithTitle:@"Don't save and cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self cancel];
    }];
    [alertController addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)hasChanges {
    if (self.passwordTextField.text.length > 0 || self.rePasswordTextField.text.length > 0) {
        return YES;
    }
    
    User *me = [AppDelegate shared].peak.me;
    User *user = [self fields];
    
    return !([user.name isEqualToString:me.name] && [user.email isEqualToString:me.email] && [user.location isEqualToString:me.location]);
}

- (User *)fields {
    User *user = [[User alloc] init];
    user.name = self.nameTextField.text;
    user.email = self.emailTextField.text;
    user.location = self.locationTextField.text;
    return user;
}

- (void)trySave {
    User *user = [self fields];
    [[AppDelegate shared].peak updateMe:user completion:^(User *user, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    CGRect frameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    frameEnd = [self.view convertRect:frameEnd fromView:nil];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    CGFloat h = self.view.bounds.size.height - frameEnd.origin.y;
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.bottom = h;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.scrollView.contentInset = inset;
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.bottom = 0;
    self.scrollView.contentInset = inset;
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
}

#pragma mark - Actions

- (IBAction)cancelAction:(id)sender {
    [self tryCancel];
}

- (IBAction)saveAction:(id)sender {
    [self trySave];
}

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)deleteAccountTouchUpInside:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete account?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (IBAction)avatarTouchUpInside:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    
    [actionSheet addButtonWithTitle:@"Take photo"];
    [actionSheet addButtonWithTitle:@"Choose from gallery"];
    [actionSheet addButtonWithTitle:@"Load from Facebook"];
    [actionSheet addButtonWithTitle:@"Delete avatar"];
    [actionSheet addButtonWithTitle:@"Canel"];
    actionSheet.destructiveButtonIndex = 3;
    actionSheet.cancelButtonIndex = 4;
    
    [actionSheet showInView:self.view];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [self.locationTextField becomeFirstResponder];
    } else if (textField == self.locationTextField) {
        [self.oldPasswordTextField becomeFirstResponder];
    } else if (textField == self.oldPasswordTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.rePasswordTextField becomeFirstResponder];
    }
    return YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAvatarButton];
    [self setupKeyboardNotifications];
    [self fillProfile];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
