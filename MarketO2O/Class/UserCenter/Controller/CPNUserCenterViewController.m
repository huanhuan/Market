//
//  CPNUserCenterViewController.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNUserCenterViewController.h"
#import "CPNUserInfoView.h"
#import "CPNUserCenterItemTableViewCell.h"
#import "CPNOrderListViewController.h"
#import "CPNCouponListManagerViewController.h"
#import "CPNAlertView.h"
#import "CPNAboutViewController.h"

static NSString *cellIdentifer = @"cellIdentifier";

@interface CPNUserCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) CPNUserInfoView   *tableHeaderView;
@property (nonatomic, strong) NSArray           *dataSource;

@end

@implementation CPNUserCenterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CPNUserCenterItem" ofType:@"plist"]];
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.height = self.view.height;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableHeaderView refreshDataView];
}

- (void)dealloc{
    
}

#pragma mark - loadView

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CPNUserCenterItemTableViewCell class] forCellReuseIdentifier:cellIdentifer];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = CPNCommonLineLayerColorColor;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (CPNUserInfoView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[CPNUserInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        _tableHeaderView.backgroundColor = CPNCommonRedColor;
    }
    return _tableHeaderView;
}


#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count > section) {
        NSArray *itemArray = self.dataSource[section];
        return itemArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CPNUserCenterItemTableViewCell cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPNUserCenterItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = CPNCommonWhiteColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.dataSource.count > indexPath.section) {
        NSArray *itemArray = self.dataSource[indexPath.section];
        if (itemArray.count > indexPath.row) {
            NSString *title  = itemArray[indexPath.row];
            cell.title = title;
            cell.iconName = [NSString stringWithFormat:@"%@icon",title];
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    if (self.appDelegate.loginUserModel) {
                        CPNOrderListViewController *orderList = [[CPNOrderListViewController alloc] init];
                        orderList.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:orderList animated:YES];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"请先登录"];
                    }
                    
                }
                    break;
                case 1:
                case 2:
                case 3:{
                    CPNAlertView *alertView = [[CPNAlertView alloc] initWithTitle:@"提示"
                                                                          message:@"此功能即将上线，敬请期待！"
                                                                     confirmTitle:@"知道了"];
                    [alertView show];
                }
                    break;
                case 4:{
                    if (self.appDelegate.loginUserModel) {
                        CPNCouponListManagerViewController *couponList = [[CPNCouponListManagerViewController alloc] init];
                        couponList.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:couponList animated:YES];
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"请先登录"];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    NSString *telPhone = @"0755-26408220";
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", telPhone]];
                    double version = [ [[UIDevice currentDevice] systemVersion] doubleValue];
                    if (version < 8.0) {
                        url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+86%@", telPhone]];
                    }
                    [[UIApplication sharedApplication] openURL:url];
                }
                    break;
                case 1:
                {
                    CPNAboutViewController *aboutVC = [[CPNAboutViewController alloc] init];
                    aboutVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:aboutVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

@end
