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
    
    if (self.bottomView) {
        [self.bottomView removeFromSuperview];
    }
    CGFloat width = [self.viewModel bottomViewWidthAtIndexPath:indexPath];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 88, width, 2)];
    self.bottomView.backgroundColor = [self.viewModel bottomViewColorAtIndexPath:indexPath];
    [self addSubview:self.bottomView];
}

@end
