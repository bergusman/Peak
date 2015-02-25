//
//  ProfileViewController.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "ProfileViewController.h"

#import "EditProfileViewController.h"
#import "PlaceViewController.h"

#import "HeaderCell.h"
#import "PlaceCell.h"
#import "CommentCell.h"
#import "LoadingImageView.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;

@property (strong, nonatomic) NSArray *data;

@end

@implementation ProfileViewController

#pragma mark - Setups

- (void)setupTableView {
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[HeaderCell nib] forCellReuseIdentifier:@"header"];
    [self.tableView registerNib:[PlaceCell nib] forCellReuseIdentifier:@"place"];
    [self.tableView registerNib:[CommentCell nib] forCellReuseIdentifier:@"comment"];
}

#pragma mark - Content

- (void)fillProfile {
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
    
    self.data = @[
                  @{@"type": @"header", @"title": @"FAVORITE PLACES"},
                  @{@"type": @"place"},
                  @{@"type": @"place"},
                  @{@"type": @"place"},
                  @{@"type": @"header", @"title": @"COMMENTS"},
                  @{@"type": @"comment"},
                  @{@"type": @"comment"},
                  @{@"type": @"comment"},
                  ];
}

#pragma mark - Actions

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editAction:(id)sender {
    EditProfileViewController *editProfileVC = [[EditProfileViewController alloc] init];
    [self presentViewController:editProfileVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = self.data[indexPath.row];
    
    if ([row[@"type"] isEqualToString:@"header"]) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        cell.titleLabel.text = row[@"title"];
        return cell;
        
    } else if ([row[@"type"] isEqualToString:@"place"]) {
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"place" forIndexPath:indexPath];
        return cell;
        
    } else if ([row[@"type"] isEqualToString:@"comment"]) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
        [cell fill];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = self.data[indexPath.row];
    
    if ([row[@"type"] isEqualToString:@"header"]) {
        return [HeaderCell height];
    } else if ([row[@"type"] isEqualToString:@"place"]) {
        return [PlaceCell height];
    } else if ([row[@"type"] isEqualToString:@"comment"]) {
        return [CommentCell height];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlaceViewController *placeVC = [[PlaceViewController alloc] init];
    [self presentViewController:placeVC animated:YES completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self fillProfile];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
