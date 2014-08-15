//
//  HDHistoryListCell.m
//  HotDaily
//
//  Created by weizhou on 8/15/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryListCell.h"

@implementation HDHistoryListCell

- (void)configureCellWith:(id)data {
    self.title.text = data[@"title"];
    self.clickCount.text = data[@"clickCount"];
}

@end
