//
//  User.h
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONCoding.h"

@interface User : NSObject <JSONCoding>

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;

@end
