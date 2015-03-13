//
//  Paginator.h
//  Peak
//
//  Created by Vitaly Berg on 09/03/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PaginatorLoadingResult)(NSArray *items, NSError *error);
typedef void (^PaginatorLoader)(NSNumber *limit, NSNumber *offset, PaginatorLoadingResult result);

@interface Paginator : NSObject

@property (strong, nonatomic, readonly) NSArray *items;
@property (assign, nonatomic, readonly) BOOL full;

@property (assign, nonatomic, readonly) BOOL refreshing;
@property (assign, nonatomic, readonly) BOOL loading;

@property (copy, nonatomic) void (^loaded)(Paginator *paginator);

- (void)refresh;
- (void)loadNext;

- (instancetype)initWithLoader:(PaginatorLoader)loader;
+ (instancetype)paginatorWithLoader:(PaginatorLoader)loader;

@end
