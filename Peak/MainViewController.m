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
#import "UIImage+Helper.h"

#import <Mapbox-iOS-SDK/Mapbox.h>

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet RMMapView *mapView;
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

- (void)setupScrollView {
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:42];
    [self.view addConstraint:topConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:bottomConstraint];
    
    NSLayoutConstraint *witdhConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:0
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:2.0
                                                                         constant:0];
    [self.view addConstraint:witdhConstraint];
}

- (void)setupMapView {
    RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"bergusman.l67hk6bp"];
    [self.mapView addTileSource:tileSource];
}

- (void)setupCollectionView {
    [self.collectionView registerNib:[PlaceCardCell nib] forCellWithReuseIdentifier:@"cell"];
}

- (void)setupTableView {
    [self.tableView registerNib:[PlaceCell nib] forCellReuseIdentifier:@"cell"];
}

- (void)setupSearch {
    id attributes = @{NSFontAttributeName: self.searchTextField.font, NSForegroundColorAttributeName: self.searchTextField.textColor};
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:attributes];}

#pragma mark - Content


#pragma mark - Actions

- (void)addAction:(id)sender {
    CreatePlaceViewController *placeVC = [[CreatePlaceViewController alloc] init];
    UINavigationController *placeNC = [[UINavigationController alloc] initWithRootViewController:placeVC];
    
    [placeNC.navigationBar setBackgroundImage:[UIImage imageWithSize:CGSizeMake(1, 64) color:RGB(40, 44, 48)] forBarMetrics:UIBarMetricsDefault];
    //[mainNC.navigationBar setShadowImage:[UIImage imageWithSize:CGSizeMake(320, 1) color:RGB(54, 254, 154)]];
    
    placeNC.navigationBar.barStyle = UIBarStyleBlack;
    
    
    [self presentViewController:placeNC animated:YES completion:nil];
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setupSearch];
    [self setupScrollView];
    [self setupMapView];
    [self setupCollectionView];
    [self setupTableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setZoom:13 atCoordinate:CLLocationCoordinate2DMake(40.746764, -73.990667) animated:NO];
    });
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
