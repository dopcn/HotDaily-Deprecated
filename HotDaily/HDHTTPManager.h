//
//  HDHTTPManager.h
//  HotDaily
//
//  Created by weizhou on 7/21/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HDHTTPManager : AFHTTPSessionManager

+ (HDHTTPManager *)sharedHTTPManager;

@end
