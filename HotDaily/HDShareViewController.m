//
//  HDShareViewController.m
//  HotDaily
//
//  Created by weizhou on 8/8/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"

@interface HDShareViewController ()
@property (nonatomic, copy) NSString *fullContent;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    self.content.text = [NSString stringWithFormat:@"发送内容:%@(%@)[来自APP热帖与八卦]",self.contentTitle, self.contentURLString];
    self.fullContent = [NSString stringWithFormat:@"发送内容:%@(%@ )[来自APP热帖与八卦]",self.contentTitle, self.contentURLString];
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

- (void)showResultMessage:(NSString *)message andHide:(BOOL)hide{
    UIView *view;
    if (hide) {
        view = self.presentingViewController.view;
    } else {
        view = self.view;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
    if (hide) {
        [self dismiss:nil];
    }
}

- (IBAction)weChatShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiSession
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败…似乎没有安装微信" andHide:NO];
                        }
                    }];
}

- (IBAction)weChatFriendsShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiTimeline
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败…似乎没有安装微信" andHide:NO];
                        }
                    }];
}

- (IBAction)qqShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeQQ
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败" andHide:NO];
                        }
                    }];
}

- (IBAction)qzoneShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:@"点击查看内容"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeQQSpace
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败" andHide:NO];
                        }
                    }];
}

- (IBAction)weiboShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:self.contentTitle
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败" andHide:NO];
                        }
                    }];
}

- (IBAction)SMSShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.fullContent
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:self.contentTitle
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSMS
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"分享成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"分享失败" andHide:NO];
                        }
                    }];
}

- (IBAction)CopyShare:(id)sender {
    id<ISSContent> publishContent = [ShareSDK content:self.contentURLString
                                       defaultContent:self.contentTitle
                                                image:nil
                                                title:self.contentTitle
                                                  url:self.contentURLString
                                          description:self.contentTitle
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeCopy
               authOptions:nil
              shareOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            [self showResultMessage:@"拷贝成功" andHide:YES];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            [self showResultMessage:@"拷贝失败" andHide:NO];
                        }
                    }];
}











@end
