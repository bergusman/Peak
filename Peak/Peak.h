//
//  Peak.h
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Place.h"
#import "Comment.h"

extern NSString * const PeakErrorDomain;

typedef NS_ENUM(NSInteger, PeakState) {
    PeakStateNone,
    PeakStateAuthed
};

@protocol PeakDelegate;

@interface Peak : NSObject

@property (strong, nonatomic, readonly) NSNumber *myId;
@property (strong, nonatomic, readonly) NSString *token;
@property (assign, nonatomic, readonly) PeakState state;

@property (strong, nonatomic, readonly) User *me;
- (void)updateMe;

- (void)clean;

- (instancetype)initWithApiUrl:(NSString *)apiUrl delegate:(id<PeakDelegate>)delegate;

- (NSURLSessionTask *)signupWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name completion:(void (^)(NSError *error))handler;
- (NSURLSessionTask *)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSError *error))handler;

- (NSURLSessionTask *)meWithCompletion:(void (^)(User *user, NSError *error))handler;
- (NSURLSessionTask *)updateMe:(User *)user completion:(void (^)(User *user, NSError *error))handler;
- (NSURLSessionTask *)deleteMeWithCompletion:(void (^)(NSError *error))handler;

- (NSURLSessionTask *)userWithId:(NSNumber *)userId completion:(void (^)(User *user, NSError *error))handler;

- (NSURLSessionTask *)placesOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler;
- (NSURLSessionTask *)favoritesOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler;
- (NSURLSessionTask *)commentsOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *comments, NSError *error))handler;

- (NSURLSessionTask *)placesWithLimit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler;
- (NSURLSessionTask *)commentsOfPlaceWithId:(NSNumber *)placeId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *comments, NSError *error))handler;

@end

@protocol PeakDelegate <NSObject>

- (void)peakDidChangeState:(Peak *)peak;

@end