//
//  HDFuninfoCell.m
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDFuninfoCell.h"
#import "HDFuninfoViewModel.h"

@implementation HDFuninfoCellWithoutImage

- (void)configureWithViewModel:(HDFuninfoViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath{
    self.viewModel = viewModel;
    self.title.text = [self.viewModel titleAtIndexPath:indexPath];
    self.bottomView.backgroundColor = [self.viewModel bottomViewColorAtIndexPath:indexPath];
    CGRect frame = self.bottomView.frame;
    CGFloat width = [self.viewModel bottomViewWidthAtIndexPath:indexPath];
    self.bottomView.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}

@end
