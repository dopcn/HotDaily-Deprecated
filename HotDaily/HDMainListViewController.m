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
#import "HDHTTPManager.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>


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
    //configure other attributes of slidingViewController in storyboard runtime attributes
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
}

- (void)bindViewModel {
    self.refreshButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSDictionary *params = @{@"pageNo": @1,
                                     @"pageSize": @50,
                                     @"orderBy": @1,
                                     @"pageBy": @1};
            [[HDHTTPManager sharedHTTPManager] GET:@"forumStand/hotw?"
                                        parameters:params
                                           success:^(NSURLSessionDataTask *task, id responseObject) {
                                               [subscriber sendNext:responseObject];
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
            self.viewModel.data = x;
        }];
    }];
    
    self.menuButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
        return [RACSignal empty];
    }];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"%@",[sender class]);
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
