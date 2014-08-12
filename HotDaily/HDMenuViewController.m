//
//  HDMenuViewController.m
//  HotDaily
//
//  Created by weizhou on 7/30/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMenuViewController.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface HDMenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSArray *menuItemIcons;
@end

@implementation HDMenuViewController

- (NSArray *)menuItems {
    if (_menuItems) return _menuItems;
    _menuItems = @[@"热帖榜", @"娱乐八卦", @"回眸经典", @"设置"];
    return _menuItems;
}

- (NSArray *)menuItemIcons {
    if (_menuItemIcons) return _menuItemIcons;
    _menuItemIcons = @[[UIImage imageNamed:@"home"],
                       [UIImage imageNamed:@"funinfo"],
                       [UIImage imageNamed:@"history"],
                       [UIImage imageNamed:@"settings"]];
    return _menuItemIcons;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.imageView.image = self.menuItemIcons[indexPath.row];
    cell.textLabel.text = self.menuItems[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TopViewController"];
            break;
        case 1:
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FuninfoViewController"];
            break;
        case 2:
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
            break;
        case 3:
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            break;
//        case 3:
//            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdViewController"];
//            break;
        default:
            break;
    }
    [self.slidingViewController resetTopViewAnimated:YES];
}





//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
