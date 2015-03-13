//
//  HDMainListViewController.m
//  HotDaily
//
//  Created by weizhou on 7/20/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListViewController.h"
#import "HDMainListViewModel.h"
#import "HDMainListCell.h"
#import "HDMainListHeaderView.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import "MBProgressHUD.h"
#import "UINavigationBar+BackgroundColor.h"

#define NAVBAR_CHANGE_POINT 50

@interface HDMainListViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation HDMainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [HDMainListViewModel new];
    [self bindViewModel];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*5/8)];
    [self.navigationController.navigationBar useBackgroundColor:[UIColor clearColor]];
    [self.refreshButton.rac_command execute:nil];
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
        [self.indicatorView stopAnimating];
    } else {
        [self.indicatorView startAnimating];
        [self.viewModel insertItemsSuccess:^{
            [self.indicatorView stopAnimating];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^{
            [self.indicatorView stopAnimating];
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierWithImage = @"MainListCellWithImage";
    static NSString *identifierWithoutImage = @"MainListCellWithoutImage";
    if ([self.viewModel hasImageAtIndexPath:indexPath]) {
        HDMainListCellWithImage *cell = [tableView dequeueReusableCellWithIdentifier:identifierWithImage forIndexPath:indexPath];
        [cell configureWithViewModel:self.viewModel atIndexPath:indexPath];
        return cell;
    } else {
        HDMainListCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:identifierWithoutImage forIndexPath:indexPath];
        [cell configureWithViewModel:self.viewModel atIndexPath:indexPath];
        return cell;
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//get rid of undeclared selector warning
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(setViewModelData:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *data = [self.viewModel dataAtIndexPath:indexPath];
        [segue.destinationViewController performSelector:@selector(setViewModelData:) withObject:data];
    }
}
#pragma clang diagnostic pop
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
