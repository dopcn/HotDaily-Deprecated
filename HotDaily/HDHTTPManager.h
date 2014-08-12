//
//  HDHTTPManager.h
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "AFHTTPSessionManager.h"

static NSString* const baseURLString = @"http://wireless.tianya.cn/v/";
static NSString* const hotListURLString = @"forumStand/hotw?";
static NSString* const funinfoListURLString = @"forumStand/list?categoryId=funinfo";

@interface HDHTTPManager : AFHTTPSessionManager

+ (HDHTTPManager *)sharedHTTPManager;

@end
