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
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>
#import <SVPullToRefresh/UIScrollView+SVInfiniteScrolling.h>


@interface HDMainListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HDMainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [HDMainListViewModel new];
    
    [self configureView];
    
    [self bindViewModel];
    
    [self.refreshButton.rac_command execute:nil];
}

- (void)configureView {
    [self setLeftNavButton];
    //configure other attributes of slidingViewController in storyboard runtime attributes
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    
    @weakify(self);
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        [self.viewModel moreItemsIn:self.tableView];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)bindViewModel {
    @weakify(self);
    self.refreshButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.viewModel GETHotListSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                [subscriber sendNext:responseObject];
                self.viewModel.numOfSections = 1;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.tableView.tableHeaderView = [[HDMainListHeaderView alloc] initWithViewModel:self.viewModel];
                    [self.tableView reloadData];
                });
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [subscriber sendError:error];
            }];
            return [RACDisposable disposableWithBlock:^{
                //
            }];
        }];
    }];
    
    [self.refreshButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeNext:^(id x) {
            @strongify(self);
            self.viewModel.data = x;
        }];
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

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MainListCellToDetail" sender:indexPath];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//get rid of undeclared selector warning
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(setViewModelData:)]) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
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
