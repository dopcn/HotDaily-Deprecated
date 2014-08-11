//
//  UIView+Capture.m
//  HotDaily
//
//  Created by weizhou on 8/8/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "UIView+Capture.h"

@implementation UIView (Capture)

- (UIImage *)captureView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImg;
}

@end
