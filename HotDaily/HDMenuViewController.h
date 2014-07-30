//
//  HDMenuViewController.h
//  HotDaily
//
//  Created by weizhou on 7/30/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) NSArray *menuItems;
@end
