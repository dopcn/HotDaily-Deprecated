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


@interface HDMainListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HDMainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [HDMainListViewModel new];
    
    [self bindViewModel];
    
    [self.refreshButton.rac_command execute:nil];
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
            //
        }];
        return [RACSignal empty];
    }];
    
    self.insertButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.insertButton.hidden = YES;
        [self.indicatorView startAnimating];
        [self.viewModel insertItemsCompletion:^{
            [self.indicatorView stopAnimating];
            self.insertButton.hidden = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:self.viewModel.numOfSections-1] withRowAnimation:UITableViewRowAnimationNone];
            });
        }];
        return [RACSignal empty];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numOfSections;
}

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [UITableViewHeaderFooterView new];
    }
    header.contentView.backgroundColor = UIColorFromRGB(0xF2EFE6);
    header.textLabel.textColor = [UIColor blackColor];
    header.textLabel.text = [self.viewModel titleForHeaderInSection:section];
    return header;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//get rid of undeclared selector warning
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender {
    [(UIViewController*)segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    if ([segue.destinationViewController respondsToSelector:@selector(setViewModelData:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *data = [self.viewModel dataAtIndexPath:indexPath];
        [segue.destinationViewController performSelector:@selector(setViewModelData:) withObject:data];
    }
}
#pragma clang diagnostic pop








//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
@end
