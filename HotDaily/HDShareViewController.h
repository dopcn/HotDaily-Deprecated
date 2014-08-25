//
//  HDShareViewController.h
//  HotDaily
//
//  Created by weizhou on 8/8/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;

@interface HDShareViewController : UIViewController
@property (strong, nonatomic) UIView *bgView;
@property (copy, nonatomic) NSString *contentTitle;
@property (copy, nonatomic) NSString *contentURLString;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *content;

- (IBAction)weChatShare:(id)sender;
- (IBAction)weChatFriendsShare:(id)sender;
- (IBAction)qqShare:(id)sender;
- (IBAction)qzoneShare:(id)sender;
- (IBAction)weiboShare:(id)sender;
- (IBAction)SMSShare:(id)sender;
- (IBAction)CopyShare:(id)sender;
- (IBAction)report:(id)sender;

@end
