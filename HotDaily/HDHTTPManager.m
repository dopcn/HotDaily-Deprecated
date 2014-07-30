//
//  HDHTTPManager.m
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHTTPManager.h"

@interface HDHTTPManager ()
- (instancetype)initWithBaseURL:(NSURL *)url;
@end

@implementation HDHTTPManager

- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

+ (HDHTTPManager *)sharedHTTPManager {
    static HDHTTPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    return manager;
}
@end
