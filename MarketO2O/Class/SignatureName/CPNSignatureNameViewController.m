//
//  CPNSignatureNameViewController.m
//  MarketO2O
//
//  Created by phh on 2017/9/3.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNSignatureNameViewController.h"
#import "PPSSignatureView.h"
#import <GLKit/GLKViewController.h>
#import "UIImage+CPNUtil.h"
#define BUTTONHEIGHT 70

@interface CPNSignatureNameViewController ()

@property (nonatomic, strong)GLKViewController *signatureViewController;

@property (nonatomic, strong)PPSSignatureView *signatureView;

@property (nonatomic, copy)SignatureNameCompleteBlock completeBlock;


@property (nonatomic, strong)UIButton *button;

@end

@implementation CPNSignatureNameViewController

- (id)initWithCompleteBlock:(SignatureNameCompleteBlock)block
{
    if (self = [super init]) {

        self.completeBlock = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBar:@"擦除" normalImageNamed:nil highImageNamed:nil];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"擦除" style:UIBarButtonItemStylePlain target:self action:@selector(erase)];
//    
////    self.navigationController.navigationItem.rightBarButtonItem = rightButton;
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.signatureViewController = [[GLKViewController alloc] init];
    [self addChildViewController:self.signatureViewController];
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    self.signatureView = [[PPSSignatureView alloc] initWithFrame:self.view.frame context:context];
    self.signatureViewController.view = self.signatureView;
    
    [self.view addSubview:self.signatureViewController.view];
    [self.signatureViewController didMoveToParentViewController:self];
    
    self.signatureViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.size.height - BUTTONHEIGHT - 64);
    self.title = @"签名";
    
    [self.button setFrame:CGRectMake(0, self.view.size.height - BUTTONHEIGHT - 64, _button.width, _button.height)];
    
    // Do any additional setup after loading the view.
}

- (void)clickedRightBarButton
{
    [self.signatureView erase];
}

- (UIButton *)button{
    if (!_button) {
        

        _button = [[UIButton alloc] initWithFrame:CGRectZero];
        [_button setBackgroundColor:CPNCommonLightRedColor];
        [_button setBackgroundImage:[UIImage createImageWithColor:CPNCommonLightRedColor] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage createImageWithColor:CPNCommonLightGrayColor] forState:UIControlStateDisabled];
        [_button.titleLabel setFont:CPNCommonFontFifteenSize];
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        [_button setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.cornerRadius = 10;
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-10);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];

    }
    return _button;
}

- (void)confirmButtonClick
{
    UIImage *image = [self.signatureView signatureImage];
    if (self.completeBlock) {
        self.completeBlock(image);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
