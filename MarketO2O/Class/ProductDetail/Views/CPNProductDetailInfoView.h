//
//  CPNProductDetailInfoView.h
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNHomePageProductItemModel;

@interface CPNProductDetailInfoView : UIView

@property (nonatomic, strong) CPNHomePageProductItemModel   *productModel;

+ (CGFloat)productInfoViewHeight;

@end
