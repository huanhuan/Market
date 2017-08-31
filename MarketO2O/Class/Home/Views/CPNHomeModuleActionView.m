//
//  CPNHomeModuleActionView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHomeModuleActionView.h"
#import "CPNImageAndTitleButton.h"

static NSInteger TagWithButton = 10000;

@interface CPNHomeModuleActionView ()

@end

@implementation CPNHomeModuleActionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CPNCommonWhiteColor;
        [self loadButtonItemView];
    }
    return self;
}

#pragma mark - loadView
- (void)loadButtonItemView{
    NSArray *titleArray = @[@"领优惠券",@"物流查询",@"客服热线",@"商品分类"];
    CGFloat buttonWidth = self.width / titleArray.count;
    CGFloat buttonHeight = self.height;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        CPNImageAndTitleButton *button = [CPNImageAndTitleButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:CPNCommonMaxDarkGrayColor forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@icon",title]] forState:UIControlStateNormal];
        button.titleLabel.font = CPNCommonFontThirteenSize;
        button.imagePosition = CPNImageAndTitleButtonImagePositionUp;
        button.imageAndTitleOffset = 10;
        button.tag = TagWithButton + i;
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}


#pragma mark - buttonAction

- (void)clickButtonAction:(UIButton *)button{
    if (self.clickButtonAction) {
        self.clickButtonAction(button.tag - TagWithButton);
    }
}


@end
