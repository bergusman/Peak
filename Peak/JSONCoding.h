//
//  JSONCoding.h
//  Peak
//
//  Created by Vitaly Berg on 01/03/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONCoding <NSObject>

- (instancetype)initWithJSON:(id)json;
- (id)JSON;

+ (instancetype)objectWithJSON:(id)json;
+ (NSArray *)objectsWithJSON:(id)json;

@end
