//
//  CreatePlaceViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "CreatePlaceViewController.h"

#import "UIFont+Helper.h"
#import "UIColor+Helper.h"

@interface CreatePlaceViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fields;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CreatePlaceViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationItem.title = @"ADD NEW PLACE";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    
    self.navigationController.navigationBar.tintColor = RGB(86, 92, 100);
    
    id attributes = @{NSFontAttributeName: [UIFont dinproBoldFontWithSize:14]};
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

- (void)setupScrollView {
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
}

#pragma mark - Actions

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPlaceTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupScrollView];
    
    for (UIView *view in self.fields) {
        view.layer.borderColor = RGB(64, 74, 84).CGColor;
        view.layer.borderWidth = 0.5;
        view.layer.cornerRadius = 2;
        view.backgroundColor = RGB(32, 36, 42);
    }
}

@end
