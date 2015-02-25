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

@interface EditProfileViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;

@end

@implementation EditProfileViewController

#pragma mark - Setups

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Content

- (void)fillProfile {
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
    
    UIImage *bg = [UIImage imageWithSize:CGSizeMake(6, 6) color:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
    bg = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.avatarButton setBackgroundImage:bg forState:UIControlStateHighlighted];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
