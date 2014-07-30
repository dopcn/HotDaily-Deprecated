//
//  HDMainListViewModel.m
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHTTPManager.h"
#import "HDMainListViewModel.h"

@implementation HDMainListViewModel

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.data[@"data"][@"list"] count];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[@"data"][@"list"][indexPath.row][@"title"];
}

- (NSURL *)imageURLAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        NSURL *url = [NSURL URLWithString:self.data[@"data"][@"list"][indexPath.row][@"pic"]];
        return url;
    } else {
        return nil;
    }
}

- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor redColor];
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data[@"data"][@"list"][indexPath.row][@"pic"]) {
        return ![self.data[@"data"][@"list"][indexPath.row][@"pic"] isEqualToString:@""];
    }
    return NO;
}

- (void)GETHotListSuccess:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{@"pageNo": @1,
                             @"pageSize": @50,
                             @"orderBy": @1,
                             @"pageBy": @1};
    [[HDHTTPManager sharedHTTPManager] GET:hotListURLString
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       success(task, responseObject);
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure(task, error);
                                   }];
}

@end
