//
//  HDMainListViewModel.m
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListViewModel.h"

@implementation HDMainListViewModel

- (NSInteger)numberOfRows {
    return [self.data[@"data"][@"list"] count];
}

- (NSString *)titleOfRow:(NSInteger)row {
    return self.data[@"data"][@"list"][row][@"title"];
}

- (UIColor *)bottomViewColorOfRow:(NSInteger)row {
    return [UIColor redColor];
}

@end
