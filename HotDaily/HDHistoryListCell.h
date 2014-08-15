//
//  HDHistoryListCell.h
//  HotDaily
//
//  Created by weizhou on 8/15/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;

@interface HDHistoryListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *clickCount;
- (void)configureCellWith:(id)data;
@end
