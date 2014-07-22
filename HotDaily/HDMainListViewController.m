//
//  HDMainListViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListViewController.h"
#import "HDMainListViewModel.h"
#import "HDMainListCell.h"

@interface HDMainListViewController ()

@end

@implementation HDMainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MainListCell";
    HDMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//TODO:[cell configureWithData:[self.viewmodel dataofindexpath:indexpath]];
    return cell;
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






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
