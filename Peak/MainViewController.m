//
//  MainViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "MainViewController.h"

#import "CreatePlaceViewController.h"
#import "ProfileViewController.h"
#import "PlaceViewController.h"

#import "PlaceCell.h"
#import "PlaceCardCell.h"

#import "UIFont+Helper.h"
#import "UIColor+Helper.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationItem.title = @"ALL PLACE AROUND YOU";
    
    self.navigationController.navigationBar.tintColor = RGB(86, 92, 100);
    
    id attributes = @{NSFontAttributeName: [UIFont dinproBoldFontWithSize:14]};
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(profileAction:)];
}

- (void)setupCollectionView {
    [self.collectionView registerNib:[PlaceCardCell nib] forCellWithReuseIdentifier:@"cell"];
}

- (void)setupTableView {
    [self.tableView registerNib:[PlaceCell nib] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Content


#pragma mark - Actions

- (void)addAction:(id)sender {
    //CreatePlaceViewController *placeVC = [[CreatePlaceViewController alloc] init];
    //[self presentViewController:placeVC animated:YES completion:nil];
}

- (void)profileAction:(id)sender {
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    [self presentViewController:profileVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell fill];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceViewController *placeVC = [[PlaceViewController alloc] init];
    [self.navigationController pushViewController:placeVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PlaceCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlaceViewController *placeVC = [[PlaceViewController alloc] init];
    [self.navigationController pushViewController:placeVC animated:YES];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupCollectionView];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.presentedViewController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

@end
