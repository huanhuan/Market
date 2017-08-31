//
//  CPNUserCenterItemTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPNUserCenterItemTableViewCell : UITableViewCell

/**
 cell图片名称
 */
@property (nonatomic, copy) NSString    *iconName;

/**
 cell标题
 */
@property (nonatomic, copy) NSString    *title;

/**
 返回cell高度
 
 @return cell高度
 */
+ (CGFloat)cellHeight;

@end
