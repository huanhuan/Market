//
//  SlideSwitchView.h
//  PoorDaily
//
//  Created by culiumac03 on 13-11-28.
//  Copyright (c) 2013年 culiumac03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (SlideSwitchView)
- (void)slideSwitchViewMadeToRefresh;
@end

@protocol SlideSwitchViewDelegate;
@interface SlideSwitchView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_rootScrollView;                  //主视图
    UIScrollView *_topScrollView;                   //顶部页签视图
    
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    NSInteger _lastSelectedChannelID;
    
//    UIImageView *_shadowImageView;
    UIView  *_shadowImageView;
    UIImage *_shadowImage;
    
    UIColor *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIView  *_rightSideView;
    
    __weak id<SlideSwitchViewDelegate> _slideSwitchViewDelegate;
}


#define kTagOfTopButton 10000

@property (nonatomic, strong) IBOutlet UIScrollView *rootScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, weak) IBOutlet id<SlideSwitchViewDelegate> slideSwitchViewDelegate;
@property (nonatomic, strong) UIFont  *tabItemFont;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) IBOutlet UIView *rightSideView;


/**
 创建子视图UI
 */
- (void)buildUI;
- (void)selectView:(NSInteger)index;

/**
 过16进制计算颜色

 @param inColorString 十六进制颜色字符串
 @return 系统颜色类
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

@protocol SlideSwitchViewDelegate <NSObject>

@required


/**
 部tab个数

 @param view view
 @return 控制器个数
 */
- (NSUInteger)numberOfTab:(SlideSwitchView *)view;


/**
 每个tab所属的viewController

 @param view 分段选择器
 @param number 控制器索引
 @return 每个tab的控制器
 */
- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional


/**
 滑动左边界时传递手势

 @param view 分段选择器
 @param panParam 手势
 */
- (void)slideSwitchView:(SlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;


/**
 滑动右边界时传递手势

 @param view 分段选择器
 @param panParam 手势
 */
- (void)slideSwitchView:(SlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;


/**
 点击tab

 @param view 分段选择器
 @param number 点击的按钮索引
 */
- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number;

@end
