//
//  HDWebViewViewController.m
//  HotDaily
//
//  Created by weizhou on 8/11/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDWebViewViewController.h"

@interface HDWebViewViewController ()

@end

@implementation HDWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)menuButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
