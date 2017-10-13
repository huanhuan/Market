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

@interface CPNContractSignViewController ()
@property (nonatomic, copy)NSString *contractImageUrl;
@property (nonatomic, strong)UIImageView *contractImageView;
@end

@implementation CPNContractSignViewController

- (id)initWithContractImageUrl:(NSString *)imageUrl
{
    if (self = [super init]) {
        self.contractImageUrl = imageUrl;
        self.title = @"电子合同";
        [self setRightBar:@"签名" normalImageNamed:nil highImageNamed:nil];

        self.contractImageView = [[UIImageView alloc] init];
        [self.view addSubview:self.contractImageView];
        [self.contractImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.and.bottom.equalTo(self.view);
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
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(tap:)];
            [weakSelf.contractImageView addGestureRecognizer:tap];
        }
    }];
    // Do any additional setup after loading the view.
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
    
}

@end
