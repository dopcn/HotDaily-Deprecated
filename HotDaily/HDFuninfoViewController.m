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
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "HDFuninfoCell.h"

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
//weird question about bottomView width
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    HDLog(@"didappear");
    //[self.tableView reloadData];
}


- (void)configureView {
    [self setLeftNavButton];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    header.text = @"红色底边的长短代表点击量的多少";
    header.textAlignment = NSTextAlignmentCenter;
    header.font = [UIFont boldSystemFontOfSize:12.0];
    header.textColor = [UIColor grayColor];
    self.tableView.tableHeaderView = header;
    
    @weakify(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        [self.refreshButton.rac_command execute:nil];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
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
            [self.viewModel GETFuninfoListSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                                           [subscriber sendNext:responseObject];
                                           self.viewModel.numOfSections = 1;
                                           dispatch_async(dispatch_get_main_queue(), ^{
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
            NSRange range;
            range.location = 0;
            range.length = 10;
            self.viewModel.listArray = [self.viewModel.data[@"data"][@"list"] subarrayWithRange:range];
            self.viewModel.numOfSections = 1;
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

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"FuninfoCellToDetail" sender:indexPath];
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
