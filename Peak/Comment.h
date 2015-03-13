//
//  Comment.h
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONCoding.h"

#import "User.h"
#import "Place.h"

@interface Comment : NSObject <JSONCoding>

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) NSNumber *placeId;
@property (strong, nonatomic) NSNumber *authorId;
@property (strong, nonatomic) NSDate *createdAt;

@property (strong, nonatomic) User *author;
@property (strong, nonatomic) Place *place;

@end
