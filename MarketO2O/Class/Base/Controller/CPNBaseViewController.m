//
//  CPNBaseViewController.m
//  
//
//  Created by CPN on 11/2/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "CPNBaseViewController.h"

@interface CPNBaseViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIImageView                *errorTipImageView;
@property (nonatomic, strong) UILabel                    *errorTipLabel;
@property (nonatomic, strong) UIButton                   *errorRetryButton;
@property (nonatomic, copy  ) CPNErrorTipViewRetryBlock  retryAction;

@end

@implementation CPNBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = CPNCommonContrllorBackgroundColor;
    [self setDefaultBar];
}


#pragma mark - loadView
- (UIView *)errorTipView{
    if (_errorTipView == nil) {
        _errorTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
        _errorTipView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_errorTipView];
    }
    return _errorTipView;
}

- (UIImageView *)errorTipImageView{
    if (_errorTipImageView == nil) {
        _errorTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"加载失败icon"]];
        [_errorTipImageView sizeToFit];
        _errorTipImageView.backgroundColor = [UIColor clearColor];
        [self.errorTipView addSubview:_errorTipImageView];
        _errorTipImageView.centerX = self.errorTipView.width/2;
    }
    return _errorTipImageView;
}

- (UILabel *)errorTipLabel{
    if (_errorTipLabel == nil) {
        _errorTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.errorTipView.width, 20)];
        _errorTipLabel.backgroundColor = [UIColor clearColor];
        _errorTipLabel.textColor = CPNColorSF(0xbdbcc5);
        _errorTipLabel.font = CPNCommonFontFourteenSize;
        _errorTipLabel.text = @"网络连接错误，请重试";
        _errorTipLabel.numberOfLines = 0;
        _errorTipLabel.textAlignment = NSTextAlignmentCenter;
        [self.errorTipView addSubview:_errorTipLabel];
    }
    return _errorTipLabel;
}


- (UIButton *)errorRetryButton{
    if (_errorRetryButton == nil) {
        _errorRetryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorRetryButton.frame = CGRectMake(0, 0, self.errorTipView.width * 0.6, 33);
        _errorRetryButton.centerX = self.errorTipView.centerX;
        _errorRetryButton.layer.cornerRadius = 2.5;
        _errorRetryButton.layer.borderWidth = 0.5;
        _errorRetryButton.layer.borderColor = CPNCommonDarkBlueColor.CGColor;
        [_errorRetryButton addTarget:self action:@selector(clickRetryAction) forControlEvents:UIControlEventTouchUpInside];
        _errorRetryButton.titleLabel.font = CPNCommonFontFifteenSize;
        [_errorRetryButton setTitleColor:CPNCommonDarkBlueColor forState:UIControlStateNormal];
        [_errorRetryButton setTitle:@"重试" forState:UIControlStateNormal];
        [self.errorTipView addSubview:_errorRetryButton];
    }
    return _errorRetryButton;
}

#pragma mark -- NavItems

- (void)setDefaultBar
{
    [self setLeftBar:nil normalImageNamed:@"返回icon-灰色" highImageNamed:@"nil"];
}


- (void)setDefaultErrorTipWithError:(CPNError *)error retryBlock:(CPNErrorTipViewRetryBlock)retryAction{
    self.retryAction = retryAction;
    self.errorTipView.hidden = NO;
    self.errorTipView.userInteractionEnabled = YES;
    if (error.errorCode == CPNErrorTypeNetworkError) {
        self.errorTipImageView.hidden =
        self.errorRetryButton.hidden = NO;
        self.errorTipLabel.text = @"网络连接错误，请重试";
        self.errorTipLabel.top = self.errorTipImageView.bottom + 11;
        self.errorRetryButton.top = self.errorTipLabel.bottom + 30;
        self.errorTipView.height = self.errorRetryButton.bottom;
    }else if (error.errorCode == CPNErrorTypeDataIsBlink){
        self.errorTipView.userInteractionEnabled = NO;
        self.errorTipImageView.hidden =
        self.errorRetryButton.hidden = YES;
        self.errorTipLabel.text = @"无数据";
        self.errorTipLabel.width = self.errorTipView.width;
        self.errorTipView.height = self.errorTipLabel.bottom;
        
    }else if (error.errorCode == CPNErrorTypeServerNotAvailable){
        self.errorTipImageView.hidden =
        self.errorRetryButton.hidden = NO;
        self.errorTipLabel.text = @"服务器出现问题，请重试";
        self.errorTipLabel.top = self.errorTipImageView.bottom + 11;
        self.errorRetryButton.top = self.errorTipLabel.bottom + 30;
        self.errorTipView.height = self.errorRetryButton.bottom;
    }else if (error.errorCode == CPNErrorTypeDataParaseError){
        self.errorTipImageView.hidden =
        self.errorRetryButton.hidden = NO;
        self.errorTipLabel.text = @"数据解析异常，请重试";
        self.errorTipLabel.top = self.errorTipImageView.bottom + 11;
        self.errorRetryButton.top = self.errorTipLabel.bottom + 30;
        self.errorTipView.height = self.errorRetryButton.bottom;
    }    self.errorTipView.center = CGPointMake(self.view.width/2, self.view.height/2 - 10);
}


/**
 *  是否需要显示请求错误的提示页面
 *
 *  @param error 请求错误
 *
 *  @return BOOL
 */
- (BOOL)isNeedShowErrorTipViewWithError:(CPNError *)error{
    if (error.errorCode == CPNErrorTypeNetworkError
        || error.errorCode == CPNErrorTypeServerNotAvailable
        || error.errorCode == CPNErrorTypeDataParaseError
        || error.errorCode == CPNErrorTypeDataIsBlink){
        return YES;
    }
    return NO;
}


- (void)setLeftBar:(NSString *)title
  normalImageNamed:(NSString *)normalImageNamed
    highImageNamed:(NSString *)highImageNamed
{
    UIButton *leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    if(title != nil){
        [[leftBarButton titleLabel] setFont:[UIFont systemFontOfSize:15.0f]];
        [leftBarButton setTitle:title forState:UIControlStateNormal];
    }
    if(normalImageNamed != nil){
        [leftBarButton setImage:[UIImage imageNamed:normalImageNamed] forState:UIControlStateNormal];
    }
    if(highImageNamed != nil){
        [leftBarButton setImage:[UIImage imageNamed:highImageNamed] forState:UIControlStateHighlighted];
    }
    [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 12)];
    [leftBarButton addTarget:self action:@selector(clickedLeftBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}



- (void)setRightBar:(NSString *)title
   normalImageNamed:(NSString *)normalImageNamed
     highImageNamed:(NSString *)highImageNamed
{
    UIButton *rightBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    
    if(normalImageNamed != nil){
        [rightBarButton setImage:[UIImage imageNamed:normalImageNamed] forState:UIControlStateNormal];
    }
    if(highImageNamed != nil){
        [rightBarButton setImage:[UIImage imageNamed:highImageNamed] forState:UIControlStateHighlighted];
    }
    
    if(title != nil){
        [[rightBarButton titleLabel] setFont:[UIFont systemFontOfSize:15.0f]];
        [rightBarButton setTitle:title forState:UIControlStateNormal];
        [[rightBarButton titleLabel] setTextAlignment:NSTextAlignmentRight];
        [rightBarButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateHighlighted];
        [rightBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, -12)];
        
        if (!normalImageNamed && !highImageNamed) {
            [rightBarButton.titleLabel sizeToFit];
            rightBarButton.width = MAX(rightBarButton.width, rightBarButton.titleLabel.width + 10);
            [rightBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, -12)];
        }
    }
    
    [rightBarButton addTarget:self action:@selector(clickedRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, 12, 0, -12)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
}


- (void)clickedLeftBarButton
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)clickedRightBarButton
{
    
}


- (void)clickRetryAction{
    if (self.retryAction) {
        self.errorTipView.hidden = YES;
        self.retryAction();
    }
}

#pragma mark - Touches events.

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [[self findFirstResponder:self.view]  resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



- (UIView *)findFirstResponder:(UIView *)baseView
{
    if (baseView == nil)
        baseView = self.view;
    
    if (baseView.isFirstResponder){
        return baseView;
    }
    for (UIView *subview in baseView.subviews) {
        UIView *firstResponder = [self findFirstResponder:subview];
        if (firstResponder != nil)
            return firstResponder;
    }
    return nil;
}

- (UIView *)findSuperViewWithKindClass:(Class)class subView:(UIView *)subView{
    if (!subView) {
        return nil;
    }
    
    UIView *supView = subView.superview;
    if ([supView isKindOfClass:class]) {
        return supView;
    }
    return [self findSuperViewWithKindClass:class subView:supView];
}



@end
