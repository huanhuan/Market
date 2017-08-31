//
//  CPNImageAndTitleButton.h
//  
//
//  Created by CPN on 16/1/20.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CPNImageAndTitleButtonImagePosition) {
    CPNImageAndTitleButtonImagePositionUp = 0,   // 图片在上
    CPNImageAndTitleButtonImagePositionDown,     // 图片在下
    CPNImageAndTitleButtonImagePositionLeft,     // 图片在左
    CPNImageAndTitleButtonImagePositionRight     // 图片在右
};

@interface CPNImageAndTitleButton : UIButton
/**
 *  图片icon
 */
@property (nonatomic, assign)CPNImageAndTitleButtonImagePosition imagePosition;

/**
 *  图片和标题间距
 */
@property (nonatomic, assign)CGFloat                             imageAndTitleOffset;

@end
