//
//  HDSplitViewController.m
//  HotDaily
//
//  Created by weizhou on 2/27/15.
//  Copyright (c) 2015 fengweizhou. All rights reserved.
//

#import "HDSplitViewController.h"

@interface HDSplitViewController ()

@end

@implementation HDSplitViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    const CGFloat kMasterViewWidth = 100.0;
    
    UIViewController *masterViewController = [self.viewControllers objectAtIndex:0];
    UIViewController *detailViewController = [self.viewControllers objectAtIndex:1];
    
    if (detailViewController.view.frame.origin.x > 0.0) {
        // Adjust the width of the master view
        CGRect masterViewFrame = masterViewController.view.frame;
        CGFloat deltaX = masterViewFrame.size.width - kMasterViewWidth;
        masterViewFrame.size.width -= deltaX;
        masterViewController.view.frame = masterViewFrame;
        
        // Adjust the width of the detail view
        CGRect detailViewFrame = detailViewController.view.frame;
        detailViewFrame.origin.x -= deltaX;
        detailViewFrame.size.width += deltaX;
        detailViewController.view.frame = detailViewFrame;
        
        [masterViewController.view setNeedsLayout];
        [detailViewController.view setNeedsLayout];
    }
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
