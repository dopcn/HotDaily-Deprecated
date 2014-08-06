//
//  HDListDetailViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDListDetailViewController.h"
#import "HDListDetailViewModel.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "HDHTTPManager.h"

@interface HDListDetailViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation HDListDetailViewController

- (void)setViewModelData:(NSDictionary *)data {
    self.viewModel = [HDListDetailViewModel new];
    self.viewModel.data = data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView handler:^(id data, WVJBResponseCallback responseCallback) {
        //
    }];
    
    self.webView.scrollView.delegate = self;
    
    [self loadHTML:_webView];
    
    NSDictionary *params = @{
                            @"categoryId":self.viewModel.data[@"categoryId"],
                            @"noteId":self.viewModel.data[@"noteId"],
                            @"pageNo":@1};
    
    [[HDHTTPManager sharedHTTPManager] GET:@"forumStand/content?" parameters:params
        success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject[@"data"]
                                                               options:0
                                                                 error:&error];
            
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [self.bridge send:jsonString];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }];
}

- (void)loadHTML:(UIWebView*)webView {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"contentView"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffY  = 0;
    float curOffY = scrollView.contentOffset.y;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    if (scrollView.frame.size.height >= scrollView.contentSize.height || //内容高度低于scrollView高度，不隐藏
        fabs(curOffY) + screenHeight > scrollView.contentSize.height  || //拉至最底部时，不做处理
        curOffY < 0                                                      //拉至最顶部时，不做处理
        )
    {
        return;
    }
    if (curOffY - lastOffY > 40)
    {
        //向上
        lastOffY = curOffY;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
        
    }
    else if(lastOffY - curOffY > 40)
    {
        //向下
        lastOffY = curOffY;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
}


//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonTapped:(id)sender {
    
}
@end
