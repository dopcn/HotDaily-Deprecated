//
//  HDFuninfoCell.h
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDFuninfoViewModel;

@interface HDFuninfoCellWithoutImage : UITableViewCell

@property (strong, nonatomic) HDFuninfoViewModel *viewModel;
- (void)configureWithViewModel:(HDFuninfoViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

