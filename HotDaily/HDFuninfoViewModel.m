//
//  HDFuninfoViewModel.m
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDFuninfoViewModel.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import "HDHTTPManager.h"

@implementation HDFuninfoViewModel

- (NSArray *)listArray {
    if (_listArray) return _listArray;
    NSRange range;
    range.location = 0;
    range.length = 10;
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
        range.location = (self.numOfSections-1)%5 * 10;
        range.length = 10;
        self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
        completion();
    } else {
        @weakify(self);
        NSDictionary *params = @{@"pageSize": @(50),
                                 @"orderBy": @2};
        [[HDHTTPManager sharedHTTPManager] GET:funinfoListURLString
                                    parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           @strongify(self);
                                           self.numOfSections = 1;
                                           self.data = responseObject;
                                           NSRange range;
                                           range.location = 0;
                                           range.length = 10;
                                           self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                           completion();
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [[HDHTTPManager sharedHTTPManager] networkFailAlert];
                                       }];
    }
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath {
    return self.listArray[indexPath.row + indexPath.section*10];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return self.listArray[indexPath.row + indexPath.section*10][@"title"];
}

- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath {
    return UIColorFromRGB(0xD0021B);
}

- (CGFloat)bottomViewWidthAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = [self.listArray[indexPath.row + indexPath.section*10][@"clickCount"] integerValue];
    if (count < 50000) {
        return (CGFloat)count*150/50000;
    } else if (count >= 50000 && count < 100000) {
        return (CGFloat)count*150/100000 + 150.0;
    } else {
        return 300.0;
    }
}

- (void)GETFuninfoListSuccess:(void (^)(void))success
                      failure:(void (^)(void))failure {
    NSDictionary *params = @{@"pageSize": @(50),
                             @"orderBy": @2};
    [[HDHTTPManager sharedHTTPManager] GET:funinfoListURLString
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       self.numOfSections = 1;
                                       self.data = responseObject;
                                       NSRange range;
                                       range.location = 0;
                                       range.length = 10;
                                       self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                       success();
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure();
                                   }];
}



@end
