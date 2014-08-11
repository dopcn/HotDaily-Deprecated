//
//  HDListDetailViewModel.m
//  HotDaily
//
//  Created by weizhou on 7/31/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDListDetailViewModel.h"
#import "HDHTTPManager.h"

@implementation HDListDetailViewModel

- (void)loadHTML:(UIWebView*)webView {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"contentView"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
}

- (void)GETDetailAtPageNo:(NSInteger)pageNo success:(void (^)(NSURLSessionDataTask *task, id responseObject, id jsonString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"categoryId":self.abstractData[@"categoryId"],
                             @"noteId":self.abstractData[@"noteId"],
                             @"pageNo":@(pageNo)};
    [[HDHTTPManager sharedHTTPManager] GET:@"forumStand/content?"
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       self.detailData = responseObject;
                                       NSError *error;
                                       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject[@"data"]
                                                                                          options:0
                                                                                            error:&error];
                                       
                                       if (! jsonData) {
                                           NSLog(@"Got an error: %@", error);
                                       } else {
                                           NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                           success(task, responseObject[@"data"], jsonString);
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       failure(task, error);
                                   }];
}

@end
