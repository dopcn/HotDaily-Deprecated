//
//  HDFuninfoViewController.m
//  HotDaily
//
//  Created by weizhou on 8/12/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDFuninfoViewController.h"
#import "HDFuninfoViewModel.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import "HDFuninfoCell.h"
#import "MJRefresh.h"

@interface HDFuninfoViewController ()

@end

@implementation HDFuninfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [HDFuninfoViewModel new];
    
    [self configureView];
    
    [self bindViewModel];
    
    [self.refreshButton.rac_command execute:nil];
}

- (void)configureView {
    @weakify(self);
    [self.tableView addHeaderWithCallback:^{
        @strongify(self);
        [self.refreshButton.rac_command execute:nil];
    }];
    [self.tableView addFooterWithCallback:^{
        @strongify(self);
        [self.viewModel insertItemsTo:self.tableView completion:^{
            [self.tableView footerEndRefreshing];
        }];
    }];
}

- (void)bindViewModel {
    @weakify(self);
    self.refreshButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.viewModel GETFuninfoListSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                                           [subscriber sendNext:responseObject];
                                            [subscriber sendCompleted];
                                           self.viewModel.numOfSections = 1;
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self.tableView reloadData];
                                           });
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
            NSRange range;
            range.location = 0;
            range.length = 10;
            self.viewModel.listArray = [self.viewModel.data[@"data"][@"list"] subarrayWithRange:range];
            self.viewModel.numOfSections = 1;
        } completed:^{
            @strongify(self);
            [self.tableView headerEndRefreshing];
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

- (HDFuninfoCellWithoutImage *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierWithoutImage = @"FuninfoCellWithoutImage";
    HDFuninfoCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:identifierWithoutImage];
    [cell configureWithViewModel:self.viewModel atIndexPath:indexPath];
    return cell;
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
