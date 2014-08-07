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
    _menuItems = @[@"头条",@"收藏",@"设置"];
    return _menuItems;
}

- (NSArray *)menuItemIcons {
    if (_menuItemIcons) return _menuItemIcons;
    _menuItemIcons = @[[UIImage imageNamed:@"home"],
                       [UIImage imageNamed:@"collection"],
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
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
            break;
        case 2:
            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            break;
//        case 3:
//            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestionViewController"];
//            break;
//        case 3:
//            self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdViewController"];
//            break;
        default:
            break;
    }
    [self.slidingViewController resetTopViewAnimated:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
