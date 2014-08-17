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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryRecordCell" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
