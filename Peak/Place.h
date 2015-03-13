//
//  Place.h
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONCoding.h"

#import "User.h"

@interface Place : NSObject <JSONCoding>

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSNumber *rate;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@property (strong, nonatomic) NSString *weburl;
@property (strong, nonatomic) NSString *phone;

@property (strong, nonatomic) NSNumber *authorId;
@property (strong, nonatomic) NSDate *createdAt;

@property (strong, nonatomic) User *author;

@end
