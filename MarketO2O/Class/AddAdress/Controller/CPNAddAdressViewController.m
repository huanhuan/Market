//
//  CPNAddAdressViewController.m
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNAddAdressViewController.h"
#import "UIAutoScrollView.h"

@interface CPNAddAdressViewController ()

@property (nonatomic, strong)UIAutoScrollView *scrollView;
@property (nonatomic, strong)UITextView *name;
@property (nonatomic, strong)UITextView *cityAddress;
@property (nonatomic, strong)UITextView *detailAddress;

@end

@implementation CPNAddAdressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView = [UIAutoScrollView new];
    [self.scrollView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.view);
    }];
    [self initViews];
}

- (void)initViews
{
    self.name = [UITextView new];
    self.name.frame = CGRectMake(100, 20, 200, 40);
    [self.name setBackgroundColor:[UIColor redColor]];
    [self.scrollView addSubview:self.name];
    self.cityAddress = [UITextView new];
    self.cityAddress.frame = CGRectMake(100, 100, 200, 40);
    [self.cityAddress setBackgroundColor:[UIColor greenColor]];
    [self.scrollView addSubview:self.cityAddress];
    self.detailAddress = [UITextView new];
    self.detailAddress.frame = CGRectMake(100, 400, 200, 40);
    [self.detailAddress setBackgroundColor:[UIColor blueColor]];
    [self.scrollView addSubview:self.detailAddress];
    [self.scrollView addAutoScrollAbility];
}

//- (void)layoutViews
//{
//    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(-20);
//        make.height.equalTo(@40);
//        make.top.mas_equalTo(20);
//    }];
//    
//    [self.cityAddress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(-20);
//        make.height.equalTo(@40);
//        make.top.equalTo(self.name.mas_bottom).offset(20);
//    }];
//    [self.detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(-20);
//        make.height.equalTo(@40);
//        make.top.equalTo(self.cityAddress.mas_bottom).offset(20);
//    }];
//}

@end
