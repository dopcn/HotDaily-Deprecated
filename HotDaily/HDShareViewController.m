//
//  HDShareViewController.m
//  HotDaily
//
//  Created by weizhou on 8/8/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDShareViewController.h"

@interface HDShareViewController ()

@end

@implementation HDShareViewController

- (UIView *)bgView {
    if (_bgView) return _bgView;
    _bgView = [[UIView alloc] initWithFrame:self.view.frame];
    _bgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [_bgView addGestureRecognizer:gr];
    return _bgView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.bgImageView removeFromSuperview];
    [self.bgView removeFromSuperview];
}












@end
