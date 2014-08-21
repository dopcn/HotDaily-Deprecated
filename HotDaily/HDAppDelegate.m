//
//  HDAppDelegate.m
//  HotDaily
//
//  Created by weizhou on 7/2/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDAppDelegate.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "WebViewProxy.h"
#import "HDCacheStore.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

static NSString* const KImageReferer = @"http://bbs.tianya.cn";

@implementation HDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xD0021B)];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIToolbar appearance] setTintColor:UIColorFromRGB(0xD0021B)];
    [[UITabBar appearance] setSelectedImageTintColor:UIColorFromRGB(0xD0021B)];
    
    NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CustomPathImages"];
    [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:KImageReferer forHTTPHeaderField:@"Referer"];
    [self setupProxy];
    
    [self shareSDKInit];
    return YES;
}

- (void)shareSDKInit {
    [ShareSDK registerApp:@"289fb2996fb8"];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"332962264"
                               appSecret:@"f080f6dbd56dfab625b2f6e0156f6398"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"
                             weiboSDKCls:[WeiboSDK class]];
    
    [ShareSDK connectWeChatWithAppId:@"wx5e8729df01addd67"
                           wechatCls:[WXApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"1102099938"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectQZoneWithAppKey:@"1102099938"
                           appSecret:@"9DtdbiTK2imubrBZ"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectCopy];
    
    [ShareSDK connectSMS];
}

- (void)setupProxy {
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:5];
    
    [WebViewProxy handleRequestsWithHost:@"img3.laibafile.cn" handler:^(NSURLRequest *req, WVPResponse *res) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:req.URL];
        [request addValue:@"http://bbs.tianya.cn" forHTTPHeaderField:@"Referer"];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [res respondWithData:data mimeType:@"image/jpg"];
        }];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    if ([[HDCacheStore sharedStore] save]) {
        NSLog(@"save success");
    } else {
        NSLog(@"save fail");
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

@end
