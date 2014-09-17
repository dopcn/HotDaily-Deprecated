//
//  HDFuninfoViewModel.h
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDFuninfoViewModel : NSObject

@property (assign, nonatomic) CGFloat screenWidth;

@property (copy, nonatomic) NSDictionary *data;
//table
@property (copy, nonatomic) NSArray *listArray;
@property (assign, nonatomic) NSInteger numOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (void)insertItemsSuccess:(void (^)(void))success
                   failure:(void (^)(void))failure;
//table cell
- (NSDictionary *)dataAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)bottomViewWidthAtIndexPath:(NSIndexPath *)indexPath;

- (void)GETFuninfoListSuccess:(void (^)(void))success
                      failure:(void (^)(void))failure;

@end
