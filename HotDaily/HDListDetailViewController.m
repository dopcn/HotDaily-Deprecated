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
#import <ReactiveCocoa/RACEXTScope.h>
#import "HDShareViewController.h"
#import "UIView+Capture.h"
#import "HDWebViewViewController.h"
#import "HDCollectionStore.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "HDHistoryRecordStore.h"


@interface HDListDetailViewController () <UIScrollViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMarginConstraint;

@end

@implementation HDListDetailViewController

- (void)setViewModelData:(NSDictionary *)data {
    self.viewModel = [HDListDetailViewModel new];
    self.viewModel.abstractData = data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView handler:^(id data, WVJBResponseCallback responseCallback) {
        //no callback now
    }];
    
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    [self.viewModel loadHTML:self.webView];
    
    self.currentPageNo = @1;
    [self bindViewModel];
    
    NSDictionary *item = @{@"title": self.viewModel.abstractData[@"title"],
                           @"categoryId": self.viewModel.abstractData[@"categoryId"],
                           @"noteId": self.viewModel.abstractData[@"noteId"],
                           @"authorId": self.viewModel.abstractData[@"authorId"]};
    [[HDHistoryRecordStore sharedStore] insertItem:item];
}

- (void)menuButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)bindViewModel {
    @weakify(self);
    [self.onlyAuthor.rac_newOnChannel subscribeNext:^(NSNumber* x) {
        @strongify(self);
        if ([x boolValue]) {
            NSMutableDictionary *data = [self.viewModel.detailData[@"data"] mutableCopy];
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", self.viewModel.abstractData[@"authorId"]];
            data[@"list"] = [data[@"list"] filteredArrayUsingPredicate:pre];
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:0
                                                                 error:&error];
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [self.bridge send:jsonString];
            }
        } else {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.viewModel.detailData[@"data"]
                                                               options:0
                                                                 error:&error];
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [self.bridge send:jsonString];
            }
        }
    }];
    
    RACSignal *pageSignal = RACObserve(self, currentPageNo);
    
    [pageSignal subscribeNext:^(NSNumber* x) {
        @strongify(self);
        [self.viewModel GETDetailAtPageNo:[x integerValue] success:^(NSURLSessionDataTask *task, id responseObject, id jsonString) {
            if (self.onlyAuthor.isOn) {
                NSMutableDictionary *data = [responseObject mutableCopy];
                NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", self.viewModel.abstractData[@"authorId"]];
                data[@"list"] = [data[@"list"] filteredArrayUsingPredicate:pre];
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:&error];
                if (! jsonData) {
                    NSLog(@"Got an error: %@", error);
                } else {
                    NSString *jsonString2 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    [self.bridge send:jsonString2];
                }
            } else {
                [self.bridge send:jsonString];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有连网 再好的戏也出不来 请刷新";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];

        }];
    }];
    
    RACSignal *canGoPrevious = [pageSignal map:^id(NSNumber* value) {
        return @([value integerValue]>1);
    }];
    
    
    RACSignal *canGoNext = [pageSignal map:^id(NSNumber* value) {
        //bad API lead to this
        NSInteger pageCount = [self.viewModel.detailData[@"data"][@"pageCount"] integerValue]?:2;
        return @(pageCount > 1 && [value integerValue] < pageCount);
    }];
    
    self.previousPage.rac_command = [[RACCommand alloc] initWithEnabled:canGoPrevious signalBlock:^RACSignal *(id input) {
            self.currentPageNo = @([self.currentPageNo integerValue]-1);
            return [RACSignal empty];
    }];
    
    self.nextPage.rac_command = [[RACCommand alloc] initWithEnabled:canGoNext
        signalBlock:^RACSignal *(id input) {
            self.currentPageNo = @([self.currentPageNo integerValue]+1);
            return [RACSignal empty];
        }];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffY = -64.0;
    CGFloat curOffY = scrollView.contentOffset.y;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    //内容高度低于scrollView高度，都不隐藏
    if (scrollView.frame.size.height >= scrollView.contentSize.height) return;
    //到达最底部
    if (fabs(curOffY) + screenHeight >= scrollView.contentSize.height) {
        self.bottomMarginConstraint.constant = 0;//this is somehow special
        [self.navigationController setToolbarHidden:NO animated:YES];
        return;
    }
    
    if (curOffY > lastOffY) //向上
    {
        lastOffY = curOffY;
        self.bottomMarginConstraint.constant = 0;
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    else if(curOffY < lastOffY)
    {
        lastOffY = curOffY;
        self.bottomMarginConstraint.constant = -44;
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (IBAction)shareButtonTapped:(id)sender {
    UIImage *bgImage = [self.navigationController.view captureView];
    HDShareViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    vc.contentTitle = self.viewModel.detailData[@"data"][@"title"];
    vc.contentURLString = self.viewModel.detailData[@"data"][@"mobileUrl"];
    [self presentViewController:vc animated:YES completion:^{
        vc.bgImageView.image = bgImage;
        [vc.view insertSubview:vc.bgView aboveSubview:vc.bgImageView];
        [UIView animateWithDuration:0.1
                         animations:^{
                             vc.bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                         }];
    }];
    
}

- (IBAction)moreMenu:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"跳页",@"收藏",@"用网页打开回复", nil];
    [sheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *message = [NSString stringWithFormat:@"%@/%@",self.currentPageNo,self.viewModel.detailData[@"data"][@"pageCount"]];
        UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"去哪一页？"
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *tf = [alertView textFieldAtIndex:0];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [alertView show];
    } else if (buttonIndex == 1) {
        NSDictionary *item = @{@"title": self.viewModel.abstractData[@"title"],
                               @"categoryId": self.viewModel.abstractData[@"categoryId"],
                               @"noteId": self.viewModel.abstractData[@"noteId"],
                               @"authorId": self.viewModel.abstractData[@"authorId"]};
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        if ([[HDCollectionStore sharedStore] insertItem:item]) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"收藏成功";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
        } else {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"收藏失败";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
        }
        [hud hide:YES afterDelay:0.8];
    } else if (buttonIndex == 2) {
        UINavigationController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
        HDWebViewViewController *vc = nvc.viewControllers[0];
        vc.urlString = self.viewModel.detailData[@"data"][@"mobileUrl"];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}


#pragma mark - alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSInteger pageNo = [[alertView textFieldAtIndex:0].text integerValue]?:1;
        pageNo = pageNo > 0 ? pageNo : 1;
        pageNo = pageNo < [self.viewModel.detailData[@"data"][@"pageCount"] integerValue] ? pageNo : [self.viewModel.detailData[@"data"][@"pageCount"] integerValue];
        self.currentPageNo = @(pageNo);
    }
}













@end
