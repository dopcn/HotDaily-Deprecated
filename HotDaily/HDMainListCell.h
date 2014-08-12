//
//  HDMainListCell.h
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDMainListViewModel;

@interface HDMainListCellWithoutImage : UITableViewCell

@property (nonatomic, strong) HDMainListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

- (void)configureWithViewModel:(HDMainListViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;

@end

@interface HDMainListCellWithImage : HDMainListCellWithoutImage

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end