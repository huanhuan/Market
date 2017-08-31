//
//  CPNHomeModuleActionView.h
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 首页顶部模块按钮操作view
 */
@interface CPNHomeModuleActionView : UIView

@property (nonatomic, copy) void    (^clickButtonAction)(NSInteger index);

@end
