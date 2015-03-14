//
//  HDMainListViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListViewControllerHD.h"
#import "HDMainListViewModel.h"
#import "HDMainListCell.h"
#import "HDMainListHeaderView.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import "MBProgressHUD.h"
#import "UINavigationBar+BackgroundColor.h"
#import "HDListDetailViewController.h"

#define NAVBAR_CHANGE_POINT 50

@interface HDMainListViewControllerHD () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation HDMainListViewControllerHD

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [HDMainListViewModel new];
    [self bindViewModel];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 200)];
    [self.navigationController.navigationBar useBackgroundColor:[UIColor clearColor]];
    [self.refreshButton.rac_command execute:nil];
    [self.tableView registerNib:[HDMainListCellWithImage cellNib] forCellReuseIdentifier:[HDMainListCellWithImage cellIdentifier]];
    [self.tableView registerNib:[HDMainListCellWithoutImage cellNib] forCellReuseIdentifier:[HDMainListCellWithoutImage cellIdentifier]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.tableView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar reset];
}

- (void)bindViewModel {
    @weakify(self);
    self.refreshButton.rac_command=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel GETHotListSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.tableHeaderView = [[HDMainListHeaderView alloc] initWithViewModel:self.viewModel];
                [self.tableView reloadData];
            });
        } failure:^{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有连网 再好的戏也出不来 请刷新";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];
        }];
        return [RACSignal empty];
    }];
}

- (void)insertItems {
    if (self.viewModel.isNoMoreData) {
    } else {
        [self.viewModel insertItemsSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^{
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.viewModel hasImageAtIndexPath:indexPath]) {
        HDMainListCellWithImage *cell = [tableView dequeueReusableCellWithIdentifier:[HDMainListCellWithImage cellIdentifier] forIndexPath:indexPath];
        [cell configureWithViewModel:self.viewModel atIndexPath:indexPath];
        return cell;
    } else {
        HDMainListCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:[HDMainListCellWithoutImage cellIdentifier] forIndexPath:indexPath];
        [cell configureWithViewModel:self.viewModel atIndexPath:indexPath];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    UIColor *color = UIColorFromRGB(0xD0021B);
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
        [self.navigationController.navigationBar useBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar useBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    if (roundf(contentHeight-offsetY-SCREEN_HEIGHT) < 50) {
        [self insertItems];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.viewModel dataAtIndexPath:indexPath];
//    [segue.destinationViewController performSelector:@selector(setViewModelData:) withObject:data];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.tableView.tableHeaderView = [[HDMainListHeaderView alloc] initWithViewModel:self.viewModel];
//        [self.tableView reloadData];
//        [self.navigationController.navigationBar useBackgroundColor:[UIColor clearColor]];
//    });
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.tableHeaderView = [[HDMainListHeaderView alloc] initWithViewModel:self.viewModel];
        [self.tableView reloadData];
        [self.navigationController.navigationBar useBackgroundColor:[UIColor clearColor]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
