//
//  HDCacheStore.m
//  HotDaily
//
//  Created by weizhou on 8/18/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDCacheStore.h"

@implementation HDCacheStore

@synthesize mainListCache = _mainListCache, funinfoListCache = _funinfoListCache;

+ (HDCacheStore *)sharedStore {
    static HDCacheStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [self new];
    });
    return store;
}

- (NSString *)dbPathWithName:(NSString *)name {
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:name];
    return dbPath;
}

- (NSArray *)mainListCache {
    if (_mainListCache) return _mainListCache;
    _mainListCache = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dbPathWithName:@"MainListCache.archive"]];
    return _mainListCache;
}

- (void)setMainListCache:(NSArray *)mainListCache {
    if (mainListCache.count < 50) {
        _mainListCache = mainListCache;
    } else {
        NSRange range;
        range.location = 0;
        range.length = 50;
        _mainListCache = [mainListCache subarrayWithRange:range];
    }
}

- (NSArray *)funinfoListCache {
    if (_funinfoListCache) return _funinfoListCache;
    _funinfoListCache = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dbPathWithName:@"FuninfoListCache.archive"]];
    return _funinfoListCache;
}

- (void)setFuninfoListCache:(NSArray *)funinfoListCache {
    if (funinfoListCache.count < 50) {
        _funinfoListCache = funinfoListCache;
    } else {
        NSRange range;
        range.location = 0;
        range.length = 50;
        _funinfoListCache = [funinfoListCache subarrayWithRange:range];
    }
}

- (BOOL)save {
    if ([NSKeyedArchiver archiveRootObject:self.mainListCache toFile:[self dbPathWithName:@"MainListCache.archive"]] && [NSKeyedArchiver archiveRootObject:self.funinfoListCache toFile:[self dbPathWithName:@"FuninfoListCache.archive"]]) {
        return YES;
    } else {
        return NO;
    }
}


@end
