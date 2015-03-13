//
//  Comment.m
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "Comment.h"
#import "NSObject+JSON.h"

@implementation Comment

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p; %@ %@>", NSStringFromClass([self class]), self, self.id, self.text];
}

#pragma mark - JSONCoding

- (instancetype)initWithJSON:(id)json {
    if (![json json_isDictionary]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _id = [json[@"id"] json_number];
        _text = [json[@"text"] json_string];
        
        _placeId = [json[@"placeId"] json_number];
        _authorId = [json[@"authorId"] json_number];
        
        _place = [[Place alloc] initWithJSON:json[@"place"]];
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
