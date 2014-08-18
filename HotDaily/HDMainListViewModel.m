//
//  HDMainListViewModel.m
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHTTPManager.h"
#import "HDMainListViewModel.h"

#import <ReactiveCocoa/RACEXTScope.h>

@implementation HDMainListViewModel

- (NSArray *)listArray {
    if (_listArray) return _listArray;
    NSRange range;
    range.location = 0;
    range.length = 20;
    _listArray = [_data[@"data"][@"list"] subarrayWithRange:range];
    return _listArray;
}

- (NSInteger)numOfSections {
    if (_numOfSections) return _numOfSections;
    _numOfSections = 1;
    return _numOfSections;
}

- (void)insertItemsCompletion:(void (^)(void))completion {
    self.numOfSections += 1;
    if ((self.numOfSections-1)%5 != 0) {
        NSRange range;
        range.location = (self.numOfSections-1)%5 * 20;
        range.length = 20;
        self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
        completion();
    } else {
        @weakify(self);
        NSDictionary *params = @{@"pageNo": @(self.numOfSections/5 + 1),
                                 @"pageSize": @(100),
                                 @"orderBy": @1,
                                 @"pageBy": @1};
        [[HDHTTPManager sharedHTTPManager] GET:hotListURLString
                                    parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           @strongify(self);
                                           if ([responseObject[@"success"] isEqualToNumber:@1]) {
                                               self.data = responseObject;
                                               NSRange range;
                                               range.location = (self.numOfSections-1)%5 * 20;
                                               range.length = 20;
                                               self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
                                           }
                                           completion();
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [[HDHTTPManager sharedHTTPManager] networkFailAlert];
                                       }];
    }
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    switch (section%2) {
        case 0: {
            NSDateFormatter *df = [NSDateFormatter new];
            [df setDateFormat:@"yyyy-MM-dd EEEE"];
            return [NSString stringWithFormat:@"今天是: %@",NSLocalizedString([df stringFromDate:[NSDate date]], nil)];
        }
            break;
        case 1: return @"Tips1:内容页点击顶部状态栏就会回到页首";
            break;
        default:
            return nil;
            break;
    }
}

- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath {
    return self.listArray[indexPath.row + indexPath.section*20];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return self.listArray[indexPath.row + indexPath.section*20][@"title"];
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArray[indexPath.row + indexPath.section*20][@"pic"]) {
        return ![self.listArray[indexPath.row + indexPath.section*20][@"pic"] isEqualToString:@""];
    }
    return NO;
}

- (NSURL *)imageURLAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        NSURL *url = [NSURL URLWithString:self.listArray[indexPath.row + indexPath.section*20][@"pic"]];
        return url;
    } else {
        return nil;
    }
}

- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath {
    return UIColorFromRGB(0xD0021B);
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
            [images addObject:@{@"url": @"http://img3.laibafile.cn/p/m/173672485.jpg",
                                @"title": @"尼玛网络速度太慢！请刷新"}];
        }
    }
    return images;
}

- (void)GETHotListSuccess:(void (^)(void))success
                  failure:(void (^)(void))failure {
    NSDictionary *params = @{@"pageNo": @(1),
                             @"pageSize": @(100),
                             @"orderBy": @1,
                             @"pageBy": @1};
    [[HDHTTPManager sharedHTTPManager] GET:hotListURLString
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       self.numOfSections = 1;
                                       self.data = responseObject;
                                       NSRange range;
                                       range.location = 0;
                                       range.length = 20;
                                       self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                       success();
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure();
                                   }];
}

@end
