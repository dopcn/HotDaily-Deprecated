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
#import "HDCacheStore.h"

@implementation HDFuninfoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _numOfSections = 1;
        _listArray = [HDCacheStore sharedStore].funinfoListCache;
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)setListArray:(NSArray *)listArray {
    [[HDCacheStore sharedStore] setFuninfoListCache:listArray];
    _listArray = listArray;
}

- (void)insertItemsSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    self.numOfSections += 1;
    if ((self.numOfSections-1)%5 != 0) {
        NSRange range;
        range.location = (self.numOfSections-1)%5 * 10;
        range.length = 10;
        self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
        success();
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
                                           if ([responseObject[@"success"] isEqualToNumber:@(1)]) {
                                               NSRange range;
                                               range.location = 0;
                                               range.length = 10;
                                               self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                               success();
                                           } else {
                                               failure();
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           failure();
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
    CGFloat base = (self.screenWidth - 20.0)/2;
    NSInteger count = [self.listArray[indexPath.row + indexPath.section*10][@"clickCount"] integerValue];
    if (count < 50000) {
        return (CGFloat)count*base/50000;
    } else if (count >= 50000 && count < 100000) {
        return (CGFloat)count*base/100000 + base;
    } else {
        return (self.screenWidth-20.0);
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
                                       if ([responseObject[@"success"] isEqualToNumber:@(1)]) {
                                           NSRange range;
                                           range.location = 0;
                                           range.length = 10;
                                           self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                       }
                                       success();
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure();
                                   }];
}



@end
