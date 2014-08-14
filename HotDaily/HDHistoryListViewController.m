//
//  HDHistoryListViewController.m
//  HotDaily
//
//  Created by weizhou on 8/13/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDHistoryListViewController.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface HDHistoryListViewController ()
@property (strong, nonatomic) NSArray *listArray;
@end

@implementation HDHistoryListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavButton];
    
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

- (void)menuButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryListCell" forIndexPath:indexPath];
    cell.textLabel.text = self.listArray[indexPath.row][@"title"];
    return cell;
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

@end
