//
//  HDMainListViewController.h
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDMainListViewModel;
@class CWStatusBarNotification;

@interface HDMainListViewController : HDBaseTableViewController

@property (strong, nonatomic) HDMainListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong ,nonatomic) CWStatusBarNotification *notification;

@end
