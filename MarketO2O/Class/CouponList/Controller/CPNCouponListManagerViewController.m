//
//  CPNCouponListManagerViewController.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNCouponListManagerViewController.h"
#import "SlideSwitchView.h"
#import "CPNCouponListSubViewController.h"

@interface CPNCouponListManagerViewController ()<SlideSwitchViewDelegate>

@property (nonatomic, strong) UIImageView       *topImageView;
@property (nonatomic, strong) SlideSwitchView   *slideSwitchView;
@property (nonatomic, strong) NSMutableArray    *controllerArray;

@end

@implementation CPNCouponListManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.slideSwitchView.top = self.topImageView.bottom;
    self.slideSwitchView.height = self.view.height - self.slideSwitchView.top;
}


#pragma mark - loadView

/**
 顶部背景图
 
 @return imageView
 */
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
        _topImageView.backgroundColor = CPNCommonOrangeColor;
        //TODO:图片
        _topImageView.image = [UIImage imageNamed:@""];
        [self.view addSubview:_topImageView];
    }
    return _topImageView;
}



/**
 分段选择按钮显示的view

 @return view
 */
- (SlideSwitchView *)slideSwitchView{
    if (_slideSwitchView == nil) {
        _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:self.view.bounds];
        _slideSwitchView.top = self.topImageView.bottom;
        _slideSwitchView.backgroundColor = [UIColor clearColor];
        _slideSwitchView.topScrollView.backgroundColor = CPNCommonWhiteColor;
        _slideSwitchView.tabItemFont = CPNCommonFontFifteenSize;
        _slideSwitchView.tabItemNormalColor = CPNCommonMiddleBlackColor;
        _slideSwitchView.tabItemSelectedColor = CPNCommonDarkOrangeColor;
        _slideSwitchView.slideSwitchViewDelegate = self;
        [self.view addSubview:_slideSwitchView];
        NSArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"已领取",@"已使用", nil];
        self.controllerArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<titleArray.count; i++) {
            CPNCouponListSubViewController *subView = [[CPNCouponListSubViewController alloc] init];
            subView.index = i;
            subView.tableView.scrollsToTop = NO;
            subView.title = [titleArray objectAtIndex:i];
            [self.controllerArray addObject:subView];
        }
        [_slideSwitchView buildUI];
        [_slideSwitchView selectView:0];
        [self slideSwitchView:_slideSwitchView didselectTab:0];
    }
    return _slideSwitchView;
}


#pragma mark - slideViewDelegate

- (NSUInteger)numberOfTab:(SlideSwitchView *)view{
    return self.controllerArray.count;
}

- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number{
    if (self.controllerArray.count == 0) {
        return;
    }
    for (CPNCouponListSubViewController *subView in self.controllerArray) {
        subView.tableView.scrollsToTop = NO;
    }
    if (self.controllerArray.count <= number) {
        number = self.controllerArray.count -1;
    }
    number = MAX(number, 0);
    CPNCouponListSubViewController *viewController = [self.controllerArray objectAtIndex:number];
    viewController.tableView.scrollsToTop = YES;
    [viewController refreshCouponDataList];
}


- (void)slideSwitchView:(SlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam{
    
}

- (void)slideSwitchView:(SlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer *)panParam{
    
}

- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number{
    if (self.controllerArray.count == 0) {
        return nil;
    }
    if (self.controllerArray.count <= number) {
        number = self.controllerArray.count -1;
    }
    number = MAX(number, 0);
    return [self.controllerArray objectAtIndex:number];
}



@end
