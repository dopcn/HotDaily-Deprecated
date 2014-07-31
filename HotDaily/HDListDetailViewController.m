//
//  HDListDetailViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDListDetailViewController.h"
#import "HDListDetailViewModel.h"

@interface HDListDetailViewController ()

@end

@implementation HDListDetailViewController

- (void)setViewModelData:(NSDictionary *)data {
    self.viewModel = [HDListDetailViewModel new];
    self.viewModel.data = data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.viewModel.data[@"title"]);
}




//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
