//
//  HDBaseViewController.m
//  HotDaily
//
//  Created by weizhou on 7/30/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDBaseViewController.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface HDBaseViewController ()

@end

@implementation HDBaseViewController

- (void)menuButtonTapped {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)setLeftNavButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end

@implementation HDBaseTableViewController

- (void)menuButtonTapped {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)setLeftNavButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
