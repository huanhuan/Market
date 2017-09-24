//
//  CPNAboutViewController.m
//  MarketO2O
//
//  Created by satyapeng on 15/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNAboutViewController.h"

@interface CPNAboutViewController ()

@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)CPNCommonLabel *versionLabel;
@property (nonatomic, strong)CPNCommonLabel *copyRightLabel;


@end

@implementation CPNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appIcon"]];
//    self.logoImage.frame = CGRectMake(0, 0, 90, 90);
//    self.logoImage.centerX = self.view.centerX;
//    self.logoImage.centerY = 80;
    [self.view addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(90);
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.top).offset(20);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.top.equalTo(self.logoImage.mas_bottom).offset(20);
    }];
    
    [self.copyRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
//    self.versionLabel setTextColor:COLOR_BLACK
}

- (CPNCommonLabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [CPNCommonLabel commonLabelWithTitle:[NSString stringWithFormat:@"%@ %@", CPN_APP_NAME, CPN_APP_VERSION]
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
        _versionLabel.numberOfLines = 1;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_versionLabel];
    }
    return _versionLabel;
}
- (CPNCommonLabel *)copyRightLabel
{
    if (!_copyRightLabel) {
        _copyRightLabel = [CPNCommonLabel commonLabelWithTitle:@"Copyright©2017\n深圳市润隆实业有限公司版权所有"
                                                    textFont:CPNCommonFontFifteenSize
                                                   textColor:CPNCommonMaxDarkGrayColor];
        _copyRightLabel.numberOfLines = 0;
        _copyRightLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_copyRightLabel];
    }
    return _copyRightLabel;
}

@end
