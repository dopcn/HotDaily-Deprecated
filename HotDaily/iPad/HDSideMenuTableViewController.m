//
//  HDSideMenuTableViewController.m
//  HotDaily
//
//  Created by weizhou on 3/1/15.
//  Copyright (c) 2015 fengweizhou. All rights reserved.
//

#import "HDSideMenuTableViewController.h"

@interface HDSideMenuTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *homeIcon;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *funinfoIcon;
@property (weak, nonatomic) IBOutlet UILabel *funinfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *settingIcon;
@property (weak, nonatomic) IBOutlet UILabel *settingLabel;

@end

@implementation HDSideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeIcon.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.funinfoIcon.image = [[UIImage imageNamed:@"funinfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.settingIcon.image = [[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self switchSideMenuItemAtRow:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self switchSideMenuItemAtRow:indexPath.row];
}

- (void)switchSideMenuItemAtRow:(NSInteger)row {
    self.homeIcon.tintColor = [UIColor grayColor];
    self.homeLabel.textColor = [UIColor grayColor];
    self.funinfoIcon.tintColor = [UIColor grayColor];
    self.funinfoLabel.textColor = [UIColor grayColor];
    self.settingIcon.tintColor = [UIColor grayColor];
    self.settingLabel.textColor = [UIColor grayColor];
    switch (row) {
        case 0:{
            self.homeIcon.tintColor = [UIColor whiteColor];
            self.homeLabel.textColor = [UIColor whiteColor];
        } break;
        case 1:{
            self.funinfoIcon.tintColor = [UIColor whiteColor];
            self.funinfoLabel.textColor = [UIColor whiteColor];
        } break;
        case 2:{
            self.settingIcon.tintColor = [UIColor whiteColor];
            self.settingLabel.textColor = [UIColor whiteColor];
        } break;
            
        default:
            break;
    }
}
@end

