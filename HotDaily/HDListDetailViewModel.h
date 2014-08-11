//
//  HDListDetailViewModel.h
//  HotDaily
//
//  Created by weizhou on 7/31/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import Foundation;

@interface HDListDetailViewModel : NSObject

@property (copy, nonatomic) NSDictionary *abstractData;
@property (copy, nonatomic) NSDictionary *detailData;

- (void)loadHTML:(UIWebView*)webView;
- (void)GETDetailAtPageNo:(NSInteger)pageNo
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject, id jsonString))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
