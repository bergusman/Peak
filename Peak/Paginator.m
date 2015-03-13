//
//  Paginator.m
//  Peak
//
//  Created by Vitaly Berg on 09/03/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "Paginator.h"

@interface Paginator ()

@property (strong, nonatomic, readwrite) NSArray *items;
@property (assign, nonatomic, readwrite) BOOL full;

@property (assign, nonatomic, readwrite) BOOL refreshing;
@property (assign, nonatomic, readwrite) BOOL loading;

@property (copy, nonatomic) PaginatorLoader loader;
@property (assign, nonatomic) NSInteger loadingIndex;

@property (strong, nonatomic) NSNumber *limit;
@property (strong, nonatomic) NSNumber *offset;

@end

@implementation Paginator

- (void)refresh {
    if (self.refreshing) {
        return;
    }
    
    self.refreshing = YES;
    self.loading = YES;
    
    self.loadingIndex++;
    
    self.loader(self.limit, @0, ^(NSArray *items, NSError *error){
        self.refreshing = NO;
        self.loading = NO;
        
        if (items) {
            self.items = items;
            
            self.offset = @(items.count);
            
            if (self.limit) {
                self.full = items.count < [self.limit integerValue];
            } else {
                self.full = items.count == 0;
            }
            
            if (self.loaded) {
                self.loaded(self);
            }
        }
    });
}

- (void)loadNext {
    if (self.loading || self.full) {
        return;
    }
    
    self.loading = YES;
    
    NSInteger loadingIndex = self.loadingIndex;
    
    self.loader(self.limit, self.offset, ^(NSArray *items, NSError *error){
        if (loadingIndex != self.loadingIndex) {
            return;
        }
        
        self.loading = NO;
        
        if (items) {
            
            if (!self.items) {
                self.items = items;
            } else {
                self.items = [self.items arrayByAddingObjectsFromArray:items];
            }
            
            self.offset = @([self.offset integerValue] + items.count);
            
            if (self.limit) {
                self.full = items.count < [self.limit integerValue];
            } else {
                self.full = items.count == 0;
            }
            
            if (self.loaded) {
                self.loaded(self);
            }
        }
    });
}

- (instancetype)initWithLoader:(PaginatorLoader)loader {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.limit = @10;
    }
    return self;
}

+ (instancetype)paginatorWithLoader:(PaginatorLoader)loader {
    return [[self alloc] initWithLoader:loader];
}

@end
