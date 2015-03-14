//
//  HDFuninfoCell.h
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDBaseCell.h"

@class HDFuninfoViewModel;

@interface HDFuninfoCellWithoutImage : HDBaseCell

@property (strong, nonatomic) HDFuninfoViewModel *viewModel;
- (void)configureWithViewModel:(HDFuninfoViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) UIView *bottomView;
@end

