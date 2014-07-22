//
//  HDMainListCell.h
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDMainListViewModel;

@interface HDMainListCellWithImage : UITableViewCell

@property (nonatomic, strong) HDMainListViewModel *viewModel;

@end

@interface HDMainListCellWithoutImage : UITableViewCell

@property (nonatomic, strong) HDMainListViewModel *viewModel;

@end