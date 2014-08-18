//
//  HDSettingsViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDSettingsViewController.h"

@interface HDSettingsViewController () <UITableViewDataSource>

@end

@implementation HDSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nightModeSwitch.rac_newOnChannel subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 1: return @"收藏列表和浏览历史都会在 APP 被删除时清空";
            break;
        default: return nil;
            break;
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                UINavigationController *nvc = (UINavigationController*)segue.destinationViewController;
                [nvc.viewControllers[0] performSelector:@selector(setUrlString:) withObject:@"http://www.tianya.cn/m"];
            } else if (indexPath.row == 2) {
                UINavigationController *nvc = (UINavigationController*)segue.destinationViewController;
                [nvc.viewControllers[0] performSelector:@selector(setUrlString:) withObject:@"http://www.tianya.cn/m"];
            }
        }
    }
}
#pragma clang diagnostic pop


@end
