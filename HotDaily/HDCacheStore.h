//
//  HDCacheStore.h
//  HotDaily
//
//  Created by weizhou on 8/18/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDCacheStore : NSObject

+ (HDCacheStore *)sharedStore;
@property (copy, nonatomic) NSArray *mainListCache;
@property (copy, nonatomic) NSArray *funinfoListCache;
- (BOOL)save;

@end
