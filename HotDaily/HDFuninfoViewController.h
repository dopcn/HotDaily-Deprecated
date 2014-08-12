//
//  HDFuninfoViewController.h
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@class HDFuninfoViewModel;
@import UIKit;

@interface HDFuninfoViewController : HDBaseTableViewController

@property (strong, nonatomic) HDFuninfoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

@end
