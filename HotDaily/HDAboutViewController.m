//
//  HDAboutViewController.m
//  HotDaily
//
//  Created by weizhou on 8/17/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDAboutViewController.h"

@interface HDAboutViewController ()

@end

@implementation HDAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
