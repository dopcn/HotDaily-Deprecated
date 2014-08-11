//
//  HDWebViewViewController.h
//  HotDaily
//
//  Created by weizhou on 8/11/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;

@interface HDWebViewViewController : HDBaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *url;
@end
