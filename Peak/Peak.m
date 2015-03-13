//
//  Peak.m
//  Peak
//
//  Created by Vitaly Berg on 28/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "Peak.h"

#import "Logger.h"

#import <AFNetworking/AFNetworking.h>

#define INVOKE_HANDLER(handler, ...) ({ if ((handler)) { (handler)(__VA_ARGS__); } })
#define ADD_PARAM(params, key, value) ({ if ((value)) { (params)[(key)] = (value); } })

@interface Peak ()

@property (strong, nonatomic) NSString *apiUrl;
@property (weak, nonatomic) id<PeakDelegate> delegate;

@property (strong, nonatomic) AFHTTPSessionManager *networking;

@property (strong, nonatomic, readwrite) NSNumber *myId;
@property (strong, nonatomic, readwrite) NSString *token;
@property (assign, nonatomic, readwrite) PeakState state;

@property (strong, nonatomic, readwrite) User *me;

@end

@implementation Peak

#pragma mark - Storage

- (void)storeToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)retrieveToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
}

- (void)storeMyId:(NSNumber *)myId {
    [[NSUserDefaults standardUserDefaults] setObject:myId forKey:@"MyId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)retrieveMyId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"MyId"];
}

#pragma mark - Content

- (void)setState:(PeakState)state {
    _state = state;
    DDLogVerbose(@"PEAK: state changed to: %ld", (long)state);
    [self.delegate peakDidChangeState:self];
}

- (void)clean {
    self.state = PeakStateNone;
    self.token = nil;
    self.myId = nil;
    
    [self storeToken:nil];
    [self storeMyId:nil];
    [self deleteAuthHeader];
}

- (void)updateMe {
    [self meWithCompletion:^(User *user, NSError *error) {
        if (error) {
        } else {
            self.me = user;
        }
    }];
}

#pragma mark - Initing

- (void)initNetworking {
    DDLogVerbose(@"PEAK: initNetworking with api url: %@", self.apiUrl);
    self.networking = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.apiUrl]];
}

- (void)initState {
    DDLogVerbose(@"PEAK: initState");
    
    self.token = [self retrieveToken];
    self.myId = [self retrieveMyId];
    
    if (self.token && self.myId) {
        DDLogVerbose(@"PEAK: initState take Authed");
        _state = PeakStateAuthed;
        [self addAuthHeader];
    } else {
        DDLogVerbose(@"PEAK: initState take None");
        _state = PeakStateNone;
    }
}

- (instancetype)initWithApiUrl:(NSString *)apiUrl delegate:(id<PeakDelegate>)delegate {
    DDLogVerbose(@"PEAK: init");
    self = [super init];
    if (self) {
        _apiUrl = apiUrl;
        _delegate = delegate;
        
        [self initNetworking];
        [self initState];
    }
    return self;
}

#pragma mark - API Networking

- (void)addAuthHeader {
    NSString *header = [NSString stringWithFormat:@"token %@", self.token];
    [self.networking.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
}

- (void)deleteAuthHeader {
    [self.networking.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
}

- (NSURLSessionTask *)POST:(NSString *)URLString params:(id)params completion:(void (^)(id result, NSError *error))handler {
    return [self.networking POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccessWithTask:task response:responseObject handler:handler];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        INVOKE_HANDLER(handler, nil, error);
    }];
}


- (NSURLSessionTask *)GET:(NSString *)URLString params:(id)params completion:(void (^)(id result, NSError *error))handler {
    return [self.networking GET:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccessWithTask:task response:responseObject handler:handler];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        INVOKE_HANDLER(handler, nil, error);
    }];
}

- (NSURLSessionTask *)PUT:(NSString *)URLString params:(id)params completion:(void (^)(id result, NSError *error))handler {
    return [self.networking PUT:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccessWithTask:task response:responseObject handler:handler];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        INVOKE_HANDLER(handler, nil, error);
    }];
}

- (NSURLSessionTask *)DELETE:(NSString *)URLString params:(id)params completion:(void (^)(id result, NSError *error))handler {
    return [self.networking DELETE:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccessWithTask:task response:responseObject handler:handler];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        INVOKE_HANDLER(handler, nil, error);
    }];
}

- (void)handleSuccessWithTask:(NSURLSessionTask *)task response:(id)response handler:(void (^)(id result, NSError *error))handler {
    INVOKE_HANDLER(handler, response, nil);
}

#pragma mark - API Methods

- (NSURLSessionTask *)signupWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name completion:(void (^)(NSError *error))handler {
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"email", email);
    ADD_PARAM(params, @"password", password);
    ADD_PARAM(params, @"name", name);
    
    return [self POST:@"users" params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, error);
        } else {
            self.token = result[@"token"];
            [self storeToken:self.token];
            
            [self addAuthHeader];
            
            User *user = [[User alloc] initWithJSON:result[@"user"]];
            self.myId = user.id;
            [self storeMyId:user.id];
            
            self.state = PeakStateAuthed;
            
            INVOKE_HANDLER(handler, nil);
        }
    }];
}

- (NSURLSessionTask *)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSError *error))handler {
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"email", email);
    ADD_PARAM(params, @"password", password);
    
    return [self POST:@"auth" params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, error);
        } else {
            self.token = result[@"token"];
            [self storeToken:self.token];
            
            [self addAuthHeader];
            
            User *user = [[User alloc] initWithJSON:result[@"user"]];
            self.myId = user.id;
            [self storeMyId:user.id];
            
            self.state = PeakStateAuthed;
            
            INVOKE_HANDLER(handler, nil);
        }
    }];
}

- (NSURLSessionTask *)meWithCompletion:(void (^)(User *user, NSError *error))handler {
    return [self GET:@"users/me" params:nil completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            User *user = [[User alloc] initWithJSON:result];
            INVOKE_HANDLER(handler, user, nil);
        }
    }];
}

- (NSURLSessionTask *)updateMe:(User *)user completion:(void (^)(User *user, NSError *error))handler {
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"email", user.email);
    ADD_PARAM(params, @"name", user.name);
    ADD_PARAM(params, @"location", user.location);
    
    return [self PUT:@"users/me" params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            User *user = [[User alloc] initWithJSON:result];
            self.me = user;
            INVOKE_HANDLER(handler, user, nil);
        }
    }];
}

- (NSURLSessionTask *)deleteMeWithCompletion:(void (^)(NSError *error))handler {
    return [self DELETE:@"users/me" params:nil completion:^(id result, NSError *error) {
        if (!error) {
            [self clean];
        }
        INVOKE_HANDLER(handler, error);
    }];
}

- (NSURLSessionTask *)userWithId:(NSNumber *)userId completion:(void (^)(User *user, NSError *error))handler {
    return nil;
}

- (NSURLSessionTask *)placesOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler {
    NSString *url = [NSString stringWithFormat:@"users/%@/places", userId];
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"limit", limit);
    ADD_PARAM(params, @"offset", offset);
    
    return [self GET:url params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            NSArray *places = [Place objectsWithJSON:result];
            INVOKE_HANDLER(handler, places, nil);
        }
    }];
}

- (NSURLSessionTask *)favoritesOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler {
    NSString *url = [NSString stringWithFormat:@"users/%@/favorites", userId];
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"limit", limit);
    ADD_PARAM(params, @"offset", offset);
    
    return [self GET:url params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            NSArray *places = [Place objectsWithJSON:result];
            INVOKE_HANDLER(handler, places, nil);
        }
    }];
}

- (NSURLSessionTask *)commentsOfUserWithId:(NSNumber *)userId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *comments, NSError *error))handler {
    NSString *url = [NSString stringWithFormat:@"users/%@/comments", userId];
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"limit", limit);
    ADD_PARAM(params, @"offset", offset);
    
    return [self GET:url params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            NSArray *comments = [Comment objectsWithJSON:result];
            INVOKE_HANDLER(handler, comments, nil);
        }
    }];
}

- (NSURLSessionTask *)placesWithLimit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *places, NSError *error))handler {
    id params = [NSMutableDictionary dictionary];
    ADD_PARAM(params, @"limit", limit);
    ADD_PARAM(params, @"offset", offset);
    
    return [self GET:@"places" params:params completion:^(id result, NSError *error) {
        if (error) {
            INVOKE_HANDLER(handler, nil, error);
        } else {
            NSArray *comments = [Place objectsWithJSON:result];
            INVOKE_HANDLER(handler, comments, nil);
        }
    }];
}

- (NSURLSessionTask *)commentsOfPlaceWithId:(NSNumber *)placeId limit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray *comments, NSError *error))handler {
    return nil;
}

@end
