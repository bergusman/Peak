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

#import "AppDelegate.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet LoadingImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;

@property (strong, nonatomic) NSArray *rows;

@property (strong, nonatomic) NSArray *placeRows;
@property (strong, nonatomic) NSArray *commentRows;

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
    User *user = self.user ?: [AppDelegate shared].peak.me;
    
    [self.avatarView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/SashaGrey/picture?type=large"]];
    
    self.nameLabel.text = user.name;
    
    if (user.location.length > 0) {
        self.homeView.hidden = NO;
        self.homeLabel.text = user.location;
    } else {
        self.homeView.hidden = YES;
    }
    
    self.editButton.hidden = ![user.id isEqualToNumber:[AppDelegate shared].peak.myId];
    
    self.rows = @[@[@"header", @"Favorites"], @[@"header", @"Comments"]];
    
    [self loadPlaces];
    [self loadComments];
}

- (void)loadPlaces {
    NSNumber *userId = self.user ? self.user.id : [AppDelegate shared].peak.myId;
    [[AppDelegate shared].peak favoritesOfUserWithId:userId limit:@10 offset:nil completion:^(NSArray *places, NSError *error) {
        if (error) {
        } else {
            NSMutableArray *placeRows = [NSMutableArray array];
            for (Place *place in places) {
                [placeRows addObject:@[@"place", place]];
            }
            self.placeRows = placeRows;
            [self fillRows];
        }
    }];
}

- (void)loadComments {
    NSNumber *userId = self.user ? self.user.id : [AppDelegate shared].peak.myId;
    [[AppDelegate shared].peak commentsOfUserWithId:userId limit:@20 offset:nil completion:^(NSArray *comments, NSError *error) {
        if (error) {
        } else {
            NSMutableArray *commentRows = [NSMutableArray array];
            for (Comment *comment in comments) {
                [commentRows addObject:@[@"comment", comment]];
            }
            self.commentRows = commentRows;
            [self fillRows];
        }
    }];
}

- (void)fillRows {
    NSMutableArray *rows = [NSMutableArray array];
    [rows addObject:@[@"header", @"Favorites"]];
    if (self.placeRows) {
        [rows addObjectsFromArray:self.placeRows];
    }
    [rows addObject:@[@"header", @"Comments"]];
    if (self.commentRows) {
        [rows addObjectsFromArray:self.commentRows];
    }
    self.rows = rows;
    [self.tableView reloadData];
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
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = self.rows[indexPath.row];
    id rowId = row[0];
    
    if ([rowId isEqualToString:@"header"]) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        cell.titleLabel.text = row[1];
        return cell;
    } else if ([rowId isEqualToString:@"place"]) {
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"place" forIndexPath:indexPath];
        return cell;
        
    } else if ([rowId isEqualToString:@"comment"]) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
        [cell fillWithComment:row[1]];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = self.rows[indexPath.row];
    id rowId = row[0];
    
    if ([rowId isEqualToString:@"header"]) {
        return [HeaderCell height];
    } else if ([rowId isEqualToString:@"place"]) {
        return [PlaceCell height];
    } else if ([rowId isEqualToString:@"comment"]) {
        return [CommentCell heightWithComment:row[1]];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id row = self.rows[indexPath.row];
    id rowId = row[0];
    
    PlaceViewController *placeVC = [[PlaceViewController alloc] init];
    
    if ([rowId isEqualToString:@"place"]) {
        placeVC.place = row[1];
    } else if ([rowId isEqualToString:@"comment"]) {
        placeVC.place = row[1];
    }
    
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
