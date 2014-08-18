//
//  HDHistoryRecordStore.m
//  HotDaily
//
//  Created by weizhou on 8/18/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryRecordStore.h"

#import <FMDB/FMDB.h>

@implementation HDHistoryRecordStore

+ (HDHistoryRecordStore *)sharedStore {
    static HDHistoryRecordStore *store = nil;
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

- (NSArray *)allItems {
    NSString *dbPath = [self dbPathWithName:@"HistoryRecordList.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        if ([db tableExists:@"HistoryRecordList"]) {
            NSInteger totalCount;
            NSString *searchAllItems = @"SELECT COUNT(*) FROM HistoryRecordList";
            NSString *searchItems;
            FMResultSet *s0 = [db executeQuery:searchAllItems];
            if ([s0 next]) {
                totalCount = [s0 intForColumnIndex:0];
            }
            if (totalCount <= 50) {
                searchItems = @"SELECT * FROM HistoryRecordList WHERE id <= 50 ORDER BY id DESC";
            } else {
                searchItems = [NSString stringWithFormat:@"SELECT * FROM HistoryRecordList WHERE id BETWEEN %ld AND %ld ORDER BY id DESC", totalCount-49, (long)totalCount];
            }
            FMResultSet *s = [db executeQuery:searchItems];
            NSMutableArray *array = [NSMutableArray array];
            while ([s next]) {
                [array addObject:[s resultDictionary]];
            }
            return [array copy];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (BOOL)insertItem:(NSDictionary *)item {
    NSString *dbPath = [self dbPathWithName:@"HistoryRecordList.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        if (![db tableExists:@"HistoryRecordList"]) {
            NSString *createTableSQL = @"CREATE TABLE HistoryRecordList (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, categoryId TEXT, noteId TEXT, authorId TEXT)";
            if (![db executeUpdate:createTableSQL]) {
                return NO;
            }
        }
        NSString *insertItemSQL = @"INSERT INTO HistoryRecordList (title, categoryId, noteId, authorId) VALUES (:title, :categoryId, :noteId, :authorId)";
        if ([db executeUpdate:insertItemSQL withParameterDictionary:item]) {
            [db close];
            return YES;
        } else {
            [db close];
            return NO;
        }
    } else {
        return NO;
    }
}

@end
