//
//  CPNUserLoginViewController.m
//  IntelligentScales
//
//  Created by CPN on 2017/7/3.
//  Copyright © 2017年 . All rights reserved.
//

#import "CPNUserLoginViewController.h"
#import "CPNLabelAndTextFieldView.h"
#import "CPNLoginUserInfoModel.h"


static CGFloat HeightWithTextField = 40;
static CGFloat HeightWithTextFieldBackView = 50;

@interface CPNUserLoginViewController ()

@property (nonatomic, strong) UIView                    *backView;

@property (nonatomic, strong) CPNLabelAndTextFieldView  *mobileTextView;

/**
 登录密码显示的view
 */
@property (nonatomic, strong) CPNLabelAndTextFieldView  *passwordTextView;

/**
 登录按钮
 */
@property (nonatomic, strong) UIButton                  *loginButton;


@end

@implementation CPNUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.mobileTextView.hidden =
    self.passwordTextView.hidden =
    self.loginButton.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


#pragma mark - loadView

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, HeightWithTextFieldBackView * 2)];
        _backView.backgroundColor = CPNCommonWhiteColor;
        [self.view addSubview:_backView];
    }
    return _backView;
}

/**
 用户名输入的view
 */
- (CPNLabelAndTextFieldView *)mobileTextView{
    if (!_mobileTextView) {
        _mobileTextView = [[CPNLabelAndTextFieldView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, HeightWithTextFieldBackView)
                                                                  tipText:@"用户名"
                                                             tipTextColor:CPNCommonMiddleBlackColor
                                                                  tipFont:CPNCommonFontFifteenSize
                                                       textFieldTextColor:CPNCommonMiddleBlackColor
                                                        textFieldTextFont:CPNCommonFontFifteenSize
                                                       textFieldPlaceHold:@"请填写用户名"];
        _mobileTextView.centerX = self.backView.width/2;
        _mobileTextView.textField.height = HeightWithTextField;
        _mobileTextView.textField.centerY = _mobileTextView.tipLabel.centerY;
        _mobileTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileTextView.textField layoutIfNeeded];
        [self.backView addSubview:_mobileTextView];
    }
    return _mobileTextView;
}

/**
 密码输入的view
 */
- (CPNLabelAndTextFieldView *)passwordTextView{
    if (!_passwordTextView) {
        _passwordTextView = [[CPNLabelAndTextFieldView alloc] initWithFrame:self.mobileTextView.frame
                                                                  tipText:@"密码"
                                                             tipTextColor:CPNCommonMiddleBlackColor
                                                                  tipFont:CPNCommonFontFifteenSize
                                                       textFieldTextColor:CPNCommonMiddleBlackColor
                                                        textFieldTextFont:CPNCommonFontFifteenSize
                                                       textFieldPlaceHold:@"请填写密码"];
        _passwordTextView.textField.frame = self.mobileTextView.textField.frame;
        _passwordTextView.top = self.mobileTextView.bottom;
        _passwordTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        [_passwordTextView.textField layoutIfNeeded];
        [self.backView addSubview:_passwordTextView];
    }
    return _passwordTextView;
}

/**
 登录按钮
 
 @return 按钮
 */
- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.backgroundColor = CPNCommonMiddleBlueColor;
        [_loginButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = CPNCommonFontFifteenSize;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.left = 20;
        _loginButton.height = HeightWithTextFieldBackView;
        _loginButton.width = self.view.width - _loginButton.left * 2;
        _loginButton.top = self.backView.bottom + 20;
        _loginButton.layer.cornerRadius = _loginButton.height/2;
        _loginButton.layer.shadowColor = CPNCommonMiddleBlueColor.CGColor;
        _loginButton.layer.shadowOffset = CGSizeMake(0, 5);
        _loginButton.layer.shadowOpacity = 0.5;
        [_loginButton addTarget:self action:@selector(clickLoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}


#pragma mark - buttonAction

/**
 点击登录按钮事件
 */
- (void)clickLoginButtonAction{
    if ([CPNInputValidUtil isBlinkString:self.mobileTextView.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入登录用户名"];
        return;
    }
    
    if ([CPNInputValidUtil isBlinkString:self.passwordTextView.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    [self requestLoginAccount];
}




#pragma mark - networkReuqest

/**
 登录请求
 */
- (void)requestLoginAccount{
    
}


#pragma mark - baseFunction
/**
 登录成功后跳转首页
 */
- (void)loginSuccessAction{
    [self clickedLeftBarButton];
}


/**
 键盘弹出收起修改遮挡
 
 @param note 消息实体
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGFloat keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGRect keyboardRect =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect editConverRect = [self.view.superview convertRect:self.view.frame toView:self.appDelegate.window];
    CGFloat height = self.appDelegate.window.height - editConverRect.origin.y;
    NSTimeInterval animationDuration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (keyBoardY == self.appDelegate.window.height) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.view.height = height;
        }];
    }else{
        [UIView animateWithDuration:animationDuration animations:^{
            self.view.height = height - keyboardRect.size.height;
        }];
    }
}


@end
