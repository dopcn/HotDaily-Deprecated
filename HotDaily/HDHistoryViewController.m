//
//  HDHistoryViewController.m
//  HotDaily
//
//  Created by weizhou on 8/13/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryViewController.h"

@interface HDHistoryViewController ()

@end

@implementation HDHistoryViewController

- (NSArray*)menuItems {
    if (_menuItems) return _menuItems;
    _menuItems = @[@"娱乐八卦", @"情感天地", @"天涯杂谈", @"国际观察"];
    return _menuItems;
}

- (NSArray*)menuIcons {
    if (_menuIcons) return _menuIcons;
    _menuIcons = @[[UIImage imageNamed:@"icon1"],
                   [UIImage imageNamed:@"icon2"],
                   [UIImage imageNamed:@"icon3"],
                   [UIImage imageNamed:@"icon4"]];
    return _menuIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    cell.textLabel.text = self.menuItems[indexPath.row];
    cell.imageView.image = self.menuIcons[indexPath.row];
    return cell;
}


#pragma mark - Navigation

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.destinationViewController respondsToSelector:@selector(setCategoryNo:)]) {
        [segue.destinationViewController performSelector:@selector(setCategoryNo:) withObject:@(indexPath.row)];
    }
}
#pragma clang diagnostic pop

@end
