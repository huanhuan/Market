//
//  CPNUserInfoView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNUserInfoView.h"
#import "CPNLoginUserInfoModel.h"
#import "UIImageView+WebCache.h"
#import "CPNUserLoginViewController.h"
#import "WXApi.h"
#import "CPNConfigSettingModel.h"
#import "CPNWeChatLoginServer.h"

@interface CPNUserInfoView ()

/**
 头像背景圆圈环
 */
@property (nonatomic, strong) UIView        *iconBackView;

/**
 头像显示
 */
@property (nonatomic, strong) UIImageView   *iconImageView;

/**
 显示昵称
 */
@property (nonatomic, strong) UILabel       *nickNameLabel;

/**
 显示积分信息
 */
@property (nonatomic, strong) UILabel       *pointsLabel;

/**
 登录按钮（假登录按钮）
 */
@property (nonatomic, strong) UIButton      *loginButton;

/**
 微信登录按钮
 */
@property (nonatomic, strong) UIButton      *wxLoginButton;

@end

@implementation CPNUserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self refreshDataView];
    }
    return self;
}

#pragma mark - loadView

/**
 头像背景

 @return view
 */
- (UIView *)iconBackView{
    if (!_iconBackView) {
        _iconBackView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
        _iconBackView.centerY = self.height/2;
        _iconBackView.backgroundColor = CPNCommonDarkRedColor;
        _iconBackView.layer.cornerRadius = _iconBackView.height/2;
        _iconBackView.clipsToBounds = YES;
        [self addSubview:_iconBackView];
    }
    return _iconBackView;
}

/**
 显示头像

 @return imageView
 */
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.iconBackView.width - 4, self.iconBackView.height - 4)];
        _iconImageView.image = [UIImage imageNamed:@"默认头像"];
        _iconImageView.layer.cornerRadius = _iconImageView.height/2;
        _iconImageView.backgroundColor = CPNCommonContrllorBackgroundColor;
        _iconImageView.center = CGPointMake(self.iconBackView.width/2, self.iconBackView.height/2);
        _iconImageView.layer.masksToBounds = YES;
        [self.iconBackView addSubview:_iconImageView];
    }
    return _iconImageView;
}


/**
 显示昵称

 @return label
 */
- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [CPNCommonLabel commonLabelWithTitle:@"微信昵称"
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonWhiteColor];
        _nickNameLabel.left = self.iconBackView.right + 15;
        _nickNameLabel.top = self.iconBackView.top + 5;
        _nickNameLabel.text = nil;
        _nickNameLabel.numberOfLines = 1;
        _nickNameLabel.width = self.width - _nickNameLabel.left - 10;
        [self addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}


/**
 显示积分

 @return label
 */
- (UILabel *)pointsLabel{
    if (!_pointsLabel) {
        _pointsLabel = [CPNCommonLabel commonLabelWithTitle:@"积分：3000"
                                                   textFont:CPNCommonFontThirteenSize
                                                  textColor:CPNCommonWhiteColor];
        _pointsLabel.text = nil;
        _pointsLabel.numberOfLines = 1;
        _pointsLabel.left = self.nickNameLabel.left;
        _pointsLabel.top = self.nickNameLabel.bottom + 10;
        _pointsLabel.width = self.nickNameLabel.width;
        [self addSubview:_pointsLabel];
    }
    return _pointsLabel;
}


/**
 登录按钮

 @return button
 */
- (UIButton *)loginButton{
    if (!_loginButton) {
//        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        _loginButton.frame = CGRectMake(self.nickNameLabel.left, 0, 100, 30);
//        _loginButton.centerY = self.height/2;
//        _loginButton.layer.borderColor = CPNCommonWhiteColor.CGColor;
//        _loginButton.layer.borderWidth = 1.0;
//        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
//        [_loginButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
//        _loginButton.titleLabel.font = CPNCommonFontFifteenSize;
//        [_loginButton addTarget:self action:@selector(clickLoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_loginButton];
    }
    return _loginButton;
}

/**
 微信登录按钮

 @return button
 */
- (UIButton *)wxLoginButton{
    if (!_wxLoginButton) {
        _wxLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _wxLoginButton.frame = CGRectMake(self.nickNameLabel.left, 0, 100, 30);;
//        _wxLoginButton.left = self.loginButton.right + 10;
        _wxLoginButton.centerY = self.height/2;
        _wxLoginButton.layer.borderColor = CPNCommonWhiteColor.CGColor;
        _wxLoginButton.layer.borderWidth = 1.0;
        [_wxLoginButton setTitle:@"微信登录" forState:UIControlStateNormal];
        [_wxLoginButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        _wxLoginButton.titleLabel.font = CPNCommonFontFifteenSize;
        [_wxLoginButton addTarget:self action:@selector(clickWXLoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_wxLoginButton];
    }
    return _wxLoginButton;
}


#pragma mark - baseFunction

/**
 刷新数据显示
 */
- (void)refreshDataView{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.loginUserModel) {
        self.nickNameLabel.hidden =
        self.pointsLabel.hidden = NO;
        self.loginButton.hidden = YES;
        self.wxLoginButton.hidden = YES;
        self.nickNameLabel.text = delegate.loginUserModel.nickname;
        self.pointsLabel.text = [NSString stringWithFormat:@"积分：%ld", delegate.loginUserModel.points];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:delegate.loginUserModel.headimgurl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }else{
        self.nickNameLabel.hidden =
        self.pointsLabel.hidden = YES;
        self.loginButton.hidden = NO;
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (delegate.configModel) {
            self.loginButton.hidden = !delegate.configModel.isShowLogin;
        }else{
            self.loginButton.hidden = NO;
        }
//        if ([WXApi isWXAppInstalled]) {
            self.wxLoginButton.hidden = NO;
//        }else{
//            self.wxLoginButton.hidden = YES;
//        }
        self.iconImageView.image = [UIImage imageNamed:@"默认头像"];
    }
}

#pragma mark - buttonAction

/**
 点击登录按钮事件
 */
- (void)clickLoginButtonAction{
    CPNUserLoginViewController *loginView = [[CPNUserLoginViewController alloc] init];
    loginView.loginSuccessBlock = ^(CPNLoginUserInfoModel *model) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.loginUserModel = model;
        [self refreshDataView];
    };
    loginView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginView animated:YES];
}


/**
 点击微信登录按钮
 */
- (void)clickWXLoginButtonAction{
//    [[CPNHTTPClient instanceClient] requestLoginWithUnionId:nil nickName:nil headerImage:nil completeBlock:^(CPNLoginUserInfoModel *infoModel, CPNError *error) {
//
//    }];
    [[CPNWeChatLoginServer sharedLoginServer] weiChatLoginActionWithSuccessBlock:^{
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[CPNHTTPClient instanceClient] requestUserInfoWithUnionId:delegate.loginUserModel completeBlock:^(CPNLoginUserInfoModel *infoModel, CPNError *error) {
            if (!error && infoModel) {
                delegate.loginUserModel = infoModel;
            }
            [self refreshDataView];
        }];
    }];
}

@end
