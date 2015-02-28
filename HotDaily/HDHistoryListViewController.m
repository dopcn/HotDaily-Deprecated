//
//  HDHistoryListViewController.m
//  HotDaily
//
//  Created by weizhou on 8/13/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryListViewController.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "HDHistoryListCell.h"

@interface HDHistoryListViewController ()
@property (strong, nonatomic) NSArray *listArray;
@end

@implementation HDHistoryListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RACSignal *categorySignal = RACObserve(self, categoryNo);
    [categorySignal subscribeNext:^(NSNumber* x) {
        self.listArray = [self readFileAtNo:x];
    }];
    
    @weakify(self);
    [[self.segControl rac_newSelectedSegmentIndexChannelWithNilValue:@0] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        switch ([x integerValue]) {
            case 0:{
                self.listArray = [self readFileAtNo:self.categoryNo];
                [self.tableView reloadData];
            }
                break;
            case 1:{
                self.listArray = [self readFile80AtNo:self.categoryNo];
                [self.tableView reloadData];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)menuButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)readFileAtNo:(NSNumber*)num {
    NSString *fileName;
    switch ([num integerValue]) {
        case 0: fileName = @"funinfo"; break;
        case 1: fileName = @"feeling"; break;
        case 2: fileName = @"free"; break;
        case 3: fileName = @"worldlook"; break;
        default:
            break;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json" inDirectory:@"historyData"];
    NSData *list = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:list
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    return array;
}

- (NSArray *)readFile80AtNo:(NSNumber*)num {
    NSString *fileName;
    switch ([num integerValue]) {
        case 0: fileName = @"funinfo80"; break;
        case 1: fileName = @"feeling80"; break;
        case 2: fileName = @"free80"; break;
        case 3: fileName = @"worldlook80"; break;
        default:
            break;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json" inDirectory:@"historyData"];
    NSData *list = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:list
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    return array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (HDHistoryListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDHistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryListCell" forIndexPath:indexPath];
    [cell configureCellWith:self.listArray[indexPath.row] atIndexPath:indexPath];
    return cell;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.destinationViewController respondsToSelector:@selector(setViewModelData:)]) {
        [segue.destinationViewController performSelector:@selector(setViewModelData:) withObject:self.listArray[indexPath.row]];
    }
}
#pragma clang diagnostic pop

@end
