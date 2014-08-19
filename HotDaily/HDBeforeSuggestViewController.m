//
//  HDBeforeSuggestViewController.m
//  HotDaily
//
//  Created by weizhou on 8/17/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDBeforeSuggestViewController.h"

@interface HDBeforeSuggestViewController ()

@end

@implementation HDBeforeSuggestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    NSArray *imageArray = @[[UIImage imageNamed:@"baozou1"],
                            [UIImage imageNamed:@"baozoumiddle"],
                            [UIImage imageNamed:@"baozou2"],
                            [UIImage imageNamed:@"baozoumiddle"],
                            [UIImage imageNamed:@"baozou3"],
                            [UIImage imageNamed:@"baozoumiddle"]];
    self.bgScrollView.contentSize = CGSizeMake(screenRect.size.width*6, screenRect.size.height);
    for (NSInteger i=0; i<6; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[i]];
        [self.bgScrollView addSubview:imageView];
        imageView.center = CGPointMake(160+320*i, CGRectGetMidY(screenRect));
    }
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
