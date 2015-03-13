//
//  User.m
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "User.h"
#import "NSObject+JSON.h"

@implementation User

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p; %@ %@ <%@>>", NSStringFromClass([self class]), self, self.id, self.name, self.email];
}

#pragma mark - JSONCoding

- (instancetype)initWithJSON:(id)json {
    if (![json json_isDictionary]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _id = [json[@"id"] json_number];
        _email = [json[@"email"] json_string];
        _name = [json[@"name"] json_string];
        _location = [json[@"location"] json_string];
    }
    return self;
}

- (id)JSON {
    return [NSDictionary dictionary];
}

+ (instancetype)objectWithJSON:(id)json {
    return [[self alloc] initWithJSON:json];
}

+ (NSArray *)objectsWithJSON:(id)json {
    return [self json_objectsWithJSON:json];
}

@end
