//
//  HDHistoryRecordStore.h
//  HotDaily
//
//  Created by weizhou on 8/18/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDHistoryRecordStore : NSObject

+ (HDHistoryRecordStore *)sharedStore;
- (BOOL)insertItem:(NSDictionary *)item;
- (NSArray *)allItems;

@end
