//
//  HDListDetailViewController.h
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDListDetailViewModel;

@interface HDListDetailViewController : HDBaseViewController

@property (strong, nonatomic) HDListDetailViewModel *viewModel;
- (void)setViewModelData:(NSDictionary *)data;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end
