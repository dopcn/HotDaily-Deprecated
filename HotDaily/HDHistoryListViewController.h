//
//  HDHistoryListViewController.h
//  HotDaily
//
//  Created by weizhou on 8/13/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;

@interface HDHistoryListViewController : HDBaseTableViewController

@property (strong, nonatomic) NSNumber *categoryNo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end
