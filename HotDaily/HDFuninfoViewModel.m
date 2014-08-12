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

- (void)moreItemsIn:(UITableView *)tableView {
    self.numOfSections += 1;
    if (self.numOfSections%5 != 0) {
        NSRange range;
        range.location = self.numOfSections%5 * 10;
        range.length = 10;
        self.listArray = [self.listArray arrayByAddingObjectsFromArray:[self.data[@"data"][@"list"] subarrayWithRange:range]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView insertSections:[NSIndexSet indexSetWithIndex:self.numOfSections-1] withRowAnimation:UITableViewRowAnimationNone];
        });
    } else {
        @weakify(self);
        [self GETFuninfoListPageSize:50
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
                             });
                         } failure:^(NSURLSessionDataTask *task, NSError *error) {
                             UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"网络请求失败"
                                                                            message:@"如果你的网络没有问题就是涯叔的服务器当机了呵呵"
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil, nil];
                             [view show];
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

- (void)GETFuninfoListPageSize:(NSInteger)size
                   success:(void (^)(NSURLSessionDataTask *, id))success
                   failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{@"pageSize": @(size),
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
