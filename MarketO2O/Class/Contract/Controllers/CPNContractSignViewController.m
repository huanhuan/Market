//
//  CPNContractSignViewController.m
//  MarketO2O
//
//  Created by satyapeng on 12/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNContractSignViewController.h"
#import "ShowImagesFullScreen.h"
#import "CPNSignatureNameViewController.h"
#import "UIImage+CPNUtil.h"

@interface CPNContractSignViewController ()
@property (nonatomic, copy)NSString *contractImageUrl;
@property (nonatomic, strong)UIImageView *contractImageView;
@property (nonatomic, strong)UIImage *contractImage;
@property (nonatomic, strong)UIButton *confirmButton;
@property (nonatomic, assign)NSUInteger shopId;
@property (nonatomic, strong)UIImage *resultImage;
@end

@implementation CPNContractSignViewController

- (id)initWithContractImageUrl:(NSString *)imageUrl shopId:(NSUInteger)shopId
{
    if (self = [super init]) {
        self.shopId = shopId;
        self.contractImageUrl = imageUrl;
        self.title = @"电子合同";
        [self setRightBar:@"签名" normalImageNamed:nil highImageNamed:nil];

        self.contractImageView = [[UIImageView alloc] init];
        [self.view addSubview:self.contractImageView];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-10);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
        
        [self.contractImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.and.equalTo(self.view);
            make.bottom.equalTo(self.confirmButton.mas_top);
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contractImageView.userInteractionEnabled = YES;
    [self.contractImageView setContentMode:UIViewContentModeScaleAspectFit];
    WeakSelf
    [self.contractImageView sd_setImageWithURL:[NSURL URLWithString:self.contractImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            weakSelf.contractImage = image;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(tap:)];
            [weakSelf.contractImageView addGestureRecognizer:tap];
        }
    }];
    // Do any additional setup after loading the view.
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmButton setBackgroundColor:CPNCommonLightRedColor];
        [_confirmButton setBackgroundImage:[UIImage createImageWithColor:CPNCommonLightRedColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage createImageWithColor:CPNCommonLightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton.titleLabel setFont:CPNCommonFontFifteenSize];
        [_confirmButton setTitle:@"上传合同" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.cornerRadius = 10;
        [self.view addSubview:_confirmButton];
        _confirmButton.enabled = NO;
    }
    return _confirmButton;
}

- (void)tap:(UITapGestureRecognizer*)tap
{
    [[ShowImagesFullScreen shareShowImagesFullScreenManager] showImages:@[self.contractImageView] currentShowImageIndex:0];
}

- (void)clickedRightBarButton
{
    CPNSignatureNameViewController *vc = [[CPNSignatureNameViewController alloc] initWithCompleteBlock:^(UIImage *signatureImage) {
        [self compose:signatureImage];
    }];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)compose:(UIImage *)signatureNameImage
{
    if (signatureNameImage) {
        
        CGImageRef imgRef2 = signatureNameImage.CGImage;
        CGFloat w2 = CGImageGetWidth(imgRef2);
        CGFloat h2 = CGImageGetHeight(imgRef2);

        //以1.png的图大小为画布创建上下文
        CGFloat width = 1080/4.0;
        CGFloat height = width/w2*h2;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [signatureNameImage drawInRect:CGRectMake(0, 0, width, height)];//先把1.png 画到上下文中
        UIImage *signName = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
        UIGraphicsEndImageContext();//关闭上下文
        
        //414
        
        UIImage *resultImage = [self addImage:signName toImage:self.contractImage];
        [self.contractImageView setImage:resultImage];
        self.resultImage = resultImage;
        _confirmButton.enabled = YES;
    }
}

- (void)confirmButtonClick:(id)sender
{
    [[CPNHTTPClient instanceClient] requestUploadContractImage:self.resultImage shopId:[NSString stringWithFormat:@"%ld", self.shopId] completeBlock:^(BOOL status, CPNError *error) {
        if (status && !error) {
            [SVProgressHUD showInfoWithStatus:@"上传成功！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"上传失败，请稍后上传！"];
        }
    }];
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    
    CGImageRef imgRef2 = image2.CGImage;
    CGFloat w2 = CGImageGetWidth(imgRef2);
    CGFloat h2 = CGImageGetHeight(imgRef2);
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w2, h2));
    [image2 drawInRect:CGRectMake(0, 0, w2, h2)];//先把1.png 画到上下文中
    [image1 drawInRect:CGRectMake(w2 - image1.size.width, h2 - image1.size.height - 50, image1.size.width, image1.size.height)];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    
    return resultImg;
}
@end
