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

- (void)insertItemsTo:(UITableView *)tableView completion:(void (^)(void))completion {
    self.numOfSections += 1;
    if (self.numOfSections%5 != 0) {
        NSRange range;
        range.location = self.numOfSections%5 * 10;
        range.length = 10;
        self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView insertSections:[NSIndexSet indexSetWithIndex:self.numOfSections-1] withRowAnimation:UITableViewRowAnimationNone];
            completion();
        });
    } else {
        @weakify(self);
        NSDictionary *params = @{@"pageSize": @(50),
                                 @"orderBy": @2};
        [[HDHTTPManager sharedHTTPManager] GET:funinfoListURLString
                                    parameters:params
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           @strongify(self);
                                           self.data = responseObject;
                                           NSRange range;
                                           range.location = 0;
                                           range.length = 10;
                                           self.listArray = [self.data[@"data"][@"list"] subarrayWithRange:range];
                                           self.numOfSections = 1;
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [tableView reloadData];
                                               [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                                               completion();
                                           });
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [[HDHTTPManager sharedHTTPManager] networkFailAlert];
                                           completion();
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

- (void)GETFuninfoListSuccess:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{@"pageSize": @(50),
                             @"orderBy": @2};
    [[HDHTTPManager sharedHTTPManager] GET:funinfoListURLString
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       success(task, responseObject);
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure(task, error);
                                   }];
}



@end
