//
//  Place.m
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "Place.h"
#import "NSObject+JSON.h"

@implementation Place

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p; %@ %@>", NSStringFromClass([self class]), self, self.id, self.title];
}

#pragma mark - JSONCoding

- (instancetype)initWithJSON:(id)json {
    if (![json json_isDictionary]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _id = [json[@"id"] json_number];
        _title = [json[@"name"] json_string];
        _details = [json[@"description"] json_string];
        _rate = [json[@"rate"] json_number];
    
        _weburl = [json[@"weburl"] json_string];
        _phone = [json[@"phone"] json_string];
        
        _authorId = [json[@"authorId"] json_number];
        
        _author = [[User alloc] initWithJSON:json[@"author"]];
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
