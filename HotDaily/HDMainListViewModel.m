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

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd EEEE"];
    return [NSString stringWithFormat:@"今天是: %@",NSLocalizedString([df stringFromDate:[NSDate date]], nil)];
}

- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[@"data"][@"list"][indexPath.row];
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
    return UIColorFromRGB(0xD0021B);
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data[@"data"][@"list"][indexPath.row][@"pic"]) {
        return ![self.data[@"data"][@"list"][indexPath.row][@"pic"] isEqualToString:@""];
    }
    return NO;
}

- (NSArray *)headerImages {
    NSMutableArray *images = [NSMutableArray array];
    for (NSDictionary *dic in self.data[@"data"][@"list"]) {
        if (dic[@"pic"] && ![dic[@"pic"] isEqualToString:@""]) {
            [images addObject:@{@"url": dic[@"pic"],
                                @"title": dic[@"title"]}];
        }
        if (images.count == 5) {
            break;
        }
    }
    //headerView must be 5
    if (images.count < 5) {
        while (images.count < 6) {
            [images addObject:images[0]];
        }
    }
    return images;
}

- (void)GETHotListNumbers:(NSInteger)num success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{@"pageNo": @1,
                             @"pageSize": @(num),
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
