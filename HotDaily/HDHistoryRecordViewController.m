//
//  HDHistoryRecordViewController.m
//  HotDaily
//
//  Created by weizhou on 8/15/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryRecordViewController.h"

@interface HDHistoryRecordViewController ()

@end

@implementation HDHistoryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
}

- (void)menuButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryRecordCell" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//get rid of undeclared selector warning
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender {
    [(UIViewController*)segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//    if ([segue.destinationViewController respondsToSelector:@selector(setViewModelData:)]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        NSDictionary *data = self.listArray[indexPath.row];
//        [segue.destinationViewController performSelector:@selector(setViewModelData:) withObject:data];
//    }
}
#pragma clang diagnostic pop


@end
