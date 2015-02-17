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

#pragma mark - Actions

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
}

@end
