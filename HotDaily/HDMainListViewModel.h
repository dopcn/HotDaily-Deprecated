//
//  HDMainListViewModel.h
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDMainListViewModel : NSObject

@property (nonatomic, strong) NSDictionary *data;

- (NSInteger)numberOfRows;
- (NSString *)titleOfRow:(NSInteger)row;
- (UIColor *)bottomViewColorOfRow:(NSInteger)row;

@end
