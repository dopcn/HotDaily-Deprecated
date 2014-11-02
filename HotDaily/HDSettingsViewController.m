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
    self.brightnessSlider.value = [UIScreen mainScreen].brightness;
    [[self.brightnessSlider rac_newValueChannelWithNilValue:@(0.5)] subscribeNext:^(NSNumber* x) {
        [UIScreen mainScreen].brightness = [x floatValue];
    }];
    
    [Flurry logEvent:@"tab 3 opened"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"寻找夜间模式？拉到最底下";
            break;
        case 1: return @"收藏列表和浏览历史都会在 APP 被删除时清空";
            break;
        case 3: return @"关于夜间模式：连续按三下屏幕下方的按键，如果没有效果请先退出应用，打开：设置-通用-辅助功能-辅助功能快捷键，选择反转颜色后重新回到这里连续按三下（什么？找不到…请不要再跟别人说你会用 iPhone 了好嘛-。-）";
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
                [nvc.viewControllers[0] performSelector:@selector(setUrlString:) withObject:@"http://bbs.tianya.cn/m/post-funinfo-5731351-1.shtml"];
            } else if (indexPath.row == 2) {
                UINavigationController *nvc = (UINavigationController*)segue.destinationViewController;
                [nvc.viewControllers[0] performSelector:@selector(setUrlString:) withObject:@"http://www.diaochapai.com/survey935284"];
            }
        }
    }
}
#pragma clang diagnostic pop


@end
