//
//  HDMainListHeaderView.h
//  HotDaily
//
//  Created by weizhou on 7/31/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

@import UIKit;
@class HDMainListViewModel;

@interface HDMainListHeaderView : UIView <UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat screenWidth;

@property (strong, nonatomic) HDMainListViewModel *viewModel;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *pageView;

- (instancetype)initWithViewModel:(HDMainListViewModel *)viewModel;

@end
