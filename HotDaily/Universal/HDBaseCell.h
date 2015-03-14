//
//  HDBaseCell.h
//  HotDaily
//
//  Created by weizhou on 3/14/15.
//  Copyright (c) 2015 fengweizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDBaseViewModel;

@interface HDBaseCell : UITableViewCell

+ (UINib *)cellNib;
//if only one kind of cell
+ (NSString *)cellIdentifier;

- (void)configureWithViewModel:(HDBaseViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;

@end
