//
//  HDMainListViewModel.h
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDMainListViewModel : NSObject

@property (nonatomic, copy) NSDictionary *data;
//table
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
//table cell
- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)imageURLAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath;
//header view
- (NSArray *)headerImages;

- (void)GETHotListNumbers:(NSInteger)num
                  success:(void (^)(NSURLSessionDataTask *, id))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
