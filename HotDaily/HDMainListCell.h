//
//  HDMainListCell.h
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDBaseCell.h"

@class HDMainListViewModel;

@interface HDMainListCellWithoutImage : HDBaseCell

@property (nonatomic, strong) HDMainListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@interface HDMainListCellWithImage : HDBaseCell

@property (nonatomic, strong) HDMainListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end