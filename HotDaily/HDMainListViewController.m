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

#import <SDWebImage/UIImageView+WebCache.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>


@interface HDMainListViewController () <UIActionSheetDelegate>

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
    self.slidingViewController.anchorRightPeekAmount = 160.0;
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
    return [self.viewModel numberOfRows];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifierWithImage = @"MainListCellWithImage";
    static NSString *identifierWithoutImage = @"MainListCellWithoutImage";
//    if (indexPath.row < 3) {
//        HDMainListCellWithImage *cell = [tableView dequeueReusableCellWithIdentifier:identifierWithImage forIndexPath:indexPath];
//        cell.title.text = @"withimagewithimagewithimagewithimage";
//        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:@"http://img3.laibafile.cn/p/m/184371599.jpg"]];
//        cell.bottomView.backgroundColor = [UIColor redColor];
//        return cell;
//    } else {
        HDMainListCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:identifierWithoutImage forIndexPath:indexPath];
        cell.title.text = [self.viewModel titleOfRow:indexPath.row];
        cell.bottomView.backgroundColor = [self.viewModel bottomViewColorOfRow:indexPath.row];
        return cell;
//    }
    
//TODO:[cell configureWithData:[self.viewmodel dataofindexpath:indexpath]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
