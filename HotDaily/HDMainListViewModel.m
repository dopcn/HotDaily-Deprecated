//
//  HDMainListViewModel.m
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListViewModel.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation HDMainListViewModel

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.data[@"data"][@"list"] count];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[@"data"][@"list"][indexPath.row][@"title"];
}

- (NSURL *)imageURLAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        NSURL *url = [NSURL URLWithString:self.data[@"data"][@"list"][indexPath.row][@"pic"]];
        return url;
    } else {
#warning handle error
        return nil;
    }
}

- (UIColor *)bottomViewColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor redColor];
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data[@"data"][@"list"][indexPath.row][@"pic"]) {
        return ![self.data[@"data"][@"list"][indexPath.row][@"pic"] isEqualToString:@""];
    }
    return NO;
}

@end
