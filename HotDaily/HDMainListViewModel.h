//
//  HDMainListViewModel.h
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDMainListViewModel : NSObject
//data = responseObject
@property (copy, nonatomic) NSDictionary *data;
//table
@property (copy, nonatomic) NSArray *listArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign, getter=isNoMoreData) BOOL noMoreData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (void)insertItemsSuccess:(void(^)(void))success
                   failure:(void(^)(void))failure;

//table cell
- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)imageURLAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath;
//header view
- (NSArray *)headerImages;

- (void)GETHotListSuccess:(void (^)(void))success
                  failure:(void (^)(void))failure;

@end
