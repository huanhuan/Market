//
//  CPNHomePageSectionHeaderView.h
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPNHomePageSectionHeaderView : UIView


/**
 组头显示的标题
 */
@property (nonatomic, copy) NSString    *title;

/**
 返回组头高度
 
 @return 组头高度
 */
+ (CGFloat)sectionHeaderHeight;

@end
