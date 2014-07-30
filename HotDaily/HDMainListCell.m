//
//  HDMainListCell.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListCell.h"
#import "HDMainListViewModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation HDMainListCellWithoutImage

- (void)configureWithViewModel:(HDMainListViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath{
    self.viewModel = viewModel;
    self.title.text = [self.viewModel titleAtIndexPath:indexPath];
    self.bottomView.backgroundColor = [self.viewModel bottomViewColorAtIndexPath:indexPath];
}

@end

@implementation HDMainListCellWithImage

- (void)configureWithViewModel:(HDMainListViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath{
    self.viewModel = viewModel;
    self.title.text = [self.viewModel titleAtIndexPath:indexPath];
    self.bottomView.backgroundColor = [self.viewModel bottomViewColorAtIndexPath:indexPath];
    [self.titleImage sd_setImageWithURL:[self.viewModel imageURLAtIndexPath:indexPath]];
}

@end


