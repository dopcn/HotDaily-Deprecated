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
    return YES;
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
    [[HDCacheStore sharedStore] save];
}

@end
