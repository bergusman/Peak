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
#import "FilterCell.h"

#import "UIFont+Helper.h"
#import "UIColor+Helper.h"
#import "UIImage+Helper.h"

#import <Mapbox-iOS-SDK/Mapbox.h>

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet RMMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *filters;

@end

@implementation MainViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationController.navigationBar.tintColor = RGB(86, 92, 100);
    
    id attributes = @{NSFontAttributeName: [UIFont dinproBoldFontWithSize:14]};
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar-plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar-profile"] style:UIBarButtonItemStylePlain target:self action:@selector(profileAction:)];
    
    self.navigationItem.title = @"ALL PLACE AROUND YOU";
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"ALL PLACE AROUND YOU";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont dinproBoldFontWithSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterTapAction:)];
    [label addGestureRecognizer:tap];
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
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:attributes];
    self.searchTableView.alpha = 0;
    [self.searchTableView registerNib:[PlaceCell nib] forCellReuseIdentifier:@"cell"];
}

- (void)setupFilter {
    self.filters = @[@"ALL PLACE AROUND YOU",
                     @"HISTORIC PLACE",
                     @"OLD TOWN",
                     @"ROMANTIC CAFE",
                     @"HIPSTER HOUSE",
                     @"ALPHA BETA MEETING PLACE",
                     @"COFFESHOP",
                     @"WINE SHOP",
                     @"CONCERT HALL",
                     @"MUSIC FESTIVALS",
                     ];
    
    [self.filterTableView registerNib:[FilterCell nib] forCellReuseIdentifier:@"cell"];
    self.filterTableView.alpha = 0;
}

#pragma mark - Content

- (void)showFilter {
    [UIView animateWithDuration:0.3 animations:^{
        self.filterTableView.alpha = 1;
    }];
}

- (void)hideFilter {
    [UIView animateWithDuration:0.3 animations:^{
        self.filterTableView.alpha = 0;
    }];
}

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

- (void)filterTapAction:(id)sender {
    if (self.filterTableView.alpha > 0.5) {
        [self hideFilter];
    } else {
        [self showFilter];
    }
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
    if (tableView == self.filterTableView) {
        return [self.filters count];
    } else {
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.filterTableView) {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text = self.filters[indexPath.row];
        return cell;
    } else {
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.filterTableView) {
        return [FilterCell height];
    } else {
        return [PlaceCell height];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.filterTableView) {
        [self hideFilter];
        ((UILabel *)self.navigationItem.titleView).text = self.filters[indexPath.row];
        [self.navigationItem.titleView sizeToFit];
    } else {
        PlaceViewController *placeVC = [[PlaceViewController alloc] init];
        [self.navigationController pushViewController:placeVC animated:YES];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.searchTableView.alpha = 1;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.searchTableView.alpha = 0;
    }];
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
    [self setupFilter];
    
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
