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

static NSString* const KImageReferer = @"http://bbs.tianya.cn";

@implementation HDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xD0021B)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"arrow"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"arrow"]];
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
}

@end
