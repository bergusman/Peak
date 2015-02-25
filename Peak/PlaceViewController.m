//
//  PlaceViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "PlaceViewController.h"

#import "PhotoCell.h"

#import "CommentCell.h"
#import "LoadingImageView.h"

@interface PlaceViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentBottomConstraint;

@end

@implementation PlaceViewController

#pragma mark - Setups

- (void)setupCollectionView {
    [self.photoCollectionView registerNib:[PhotoCell nib] forCellWithReuseIdentifier:@"cell"];
}

- (void)setupTableView {
    [self.tableView registerNib:[CommentCell nib] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Content

- (void)fill {
    
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    CGRect frameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    frameEnd = [self.view convertRect:frameEnd fromView:nil];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    CGFloat h = self.view.bounds.size.height - frameEnd.origin.y;
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = h + 44;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.tableView.contentInset = inset;
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        self.commentBottomConstraint.constant = h;
        [self.view layoutSubviews];
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    CGRect frameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    frameEnd = [self.view convertRect:frameEnd fromView:nil];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = curve << 16;
    
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = 44;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.tableView.contentInset = inset;
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        self.commentBottomConstraint.constant = 0;
        [self.view layoutSubviews];
    } completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell fill];
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell fill];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommentCell height];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTableView];
    [self setupCollectionView];
    [self setupKeyboardNotifications];
    [self fill];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
