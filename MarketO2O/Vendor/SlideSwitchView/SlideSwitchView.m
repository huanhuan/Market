//
//  SlideSwitchView.m
//  PoorDaily
//
//  Created by culiumac03 on 13-11-28.
//  Copyright (c) 2013年 culiumac03. All rights reserved.
//

#import "SlideSwitchView.h"


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonPadding = 13.0f;
static const NSUInteger kTagOfRightSideView = 999;

@implementation SlideSwitchView {
    UIView *backgroundView;
    BOOL    isEndLastScroll;
}

#pragma mark - 初始化参数

- (void)initValues
{
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.bounces=NO;
    _topScrollView.scrollsToTop=NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = kTagOfTopButton;
    _lastSelectedChannelID = _userSelectedChannelID;
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.scrollsToTop=NO;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.scrollsToTop = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _rootScrollView.scrollEnabled = NO;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [NSMutableArray array];
    
    _isBuildUI = NO;
    
    isEndLastScroll = YES;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRightSideView:(UIView *)rightSideView
{
    UIView *rightView = (UIView *)[self viewWithTag:kTagOfRightSideView];
    [rightView removeFromSuperview];
    rightSideView.tag = kTagOfRightSideView;
    _rightSideView = rightSideView;
    [self addSubview:rightSideView];
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局，同时也是一个初始化方法。
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rightSideView.bounds.size.width > 0) {
            _rightSideView.frame = CGRectMake(self.bounds.size.width - self.rightSideView.bounds.size.width, 0,
                                                _rightSideView.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rightSideView.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - kTagOfTopButton)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}


/**
 创建子视图UI
 */
- (void)buildUI
{
    [self.topScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rootScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_viewArray removeAllObjects];
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    //调用layoutSubView来实现view中subView的重新布局
    [self setNeedsLayout];
}


/**
 * 初始化顶部tab的各个按钮
 */
- (void)createNameButtons
{
    
    UIImageView *underLine=[[UIImageView alloc] initWithFrame:CGRectZero];
    underLine.backgroundColor=CPNCommonLineLayerColorColor;
    [_topScrollView addSubview:underLine];
    _shadowImageView = [[UIView alloc] init];
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH/2, kHeightOfTopScrollView - 2.0f, 0.0f, 2.0f)];
    backgroundView.backgroundColor = CPNCommonRedColor;
    [_shadowImageView addSubview:backgroundView];
    [_topScrollView addSubview:_shadowImageView];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = 0;
    //每个tab偏移量
    CGFloat xOffset = 0;
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize textSize = [vc.title sizeWithFont:self.tabItemFont
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        //累计每个tab文字的长度
        topScrollViewContentWidth += (kWidthOfButtonPadding*2+textSize.width);
        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset, 0, textSize.width + kWidthOfButtonPadding*2, kHeightOfTopScrollView)];
        //计算下一个tab的x偏移量
        xOffset += (textSize.width + kWidthOfButtonPadding * 2);
        
        [button setTag:i+kTagOfTopButton];
        if (i == 0) {
            _shadowImageView.frame = CGRectMake(0, 0, button.bounds.size.width, kHeightOfTopScrollView);
            _shadowImageView.centerX = button.centerX;
            backgroundView.width = textSize.width;
            backgroundView.centerX = _shadowImageView.width / 2.0f;
            button.selected = YES;
        }
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = self.tabItemFont;
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
    }
    
    //设置顶部滚动视图的内容总尺寸
    if (topScrollViewContentWidth < self.topScrollView.width) {
        CGFloat blankWidth = (self.topScrollView.width - topScrollViewContentWidth) / [_viewArray count];
        CGFloat xOffset = 0;
        for (int i = 0; i < [_viewArray count]; i++) {
            UIButton *button = (UIButton *)[_topScrollView viewWithTag:i+kTagOfTopButton];
            button.frame = CGRectMake(xOffset, 0.0f, button.bounds.size.width + blankWidth, button.bounds.size.height);
            xOffset += button.bounds.size.width;

            CGSize textSize = [button.titleLabel.text sizeWithFont:self.tabItemFont
                                                 constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                                     lineBreakMode:NSLineBreakByTruncatingTail];
            if (i == 0) {
                _shadowImageView.frame = CGRectMake(0, 0, button.bounds.size.width, kHeightOfTopScrollView);
                backgroundView.width = textSize.width;
                backgroundView.centerX = _shadowImageView.width / 2.0f;
                button.selected = YES;
            }
        }
        topScrollViewContentWidth = _topScrollView.width;
    }

    underLine.frame = CGRectMake(0, kHeightOfTopScrollView - 0.5f, topScrollViewContentWidth, 0.5f);
    
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
}


#pragma mark - 顶部滚动视图逻辑方法


/**
 选中tab事件

 @param sender 按钮
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID&&sender) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    } else {
        if (!_isRootScroll) {
            if (_viewArray.count!=0) {
                id controller = _viewArray[_userSelectedChannelID - kTagOfTopButton];
                if ([controller respondsToSelector:@selector(slideSwitchViewMadeToRefresh)]) {
                    [controller slideSwitchViewMadeToRefresh];
                }
            }
        }
    }
    
    //按钮选中状态
    if (_isRootScroll || !sender.selected) {
        sender.selected = YES;
        self.rootScrollView.scrollEnabled = YES;

        [UIView animateWithDuration:0.1 animations:^{
            
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, kHeightOfTopScrollView)];
            CGSize textSize = [sender.titleLabel.text sizeWithFont:self.tabItemFont
                                                 constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                                     lineBreakMode:NSLineBreakByTruncatingTail];
            backgroundView.width = textSize.width;
            backgroundView.centerX = _shadowImageView.width / 2.0f;
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                self.rootScrollView.scrollEnabled = NO;
                if (!_isRootScroll) {
                    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                        _rootScrollView.contentOffset = CGPointMake((sender.tag - kTagOfTopButton)*self.bounds.size.width, 0);
                    } completion:^(BOOL finished) {
                        if (_viewArray.count!=0) {
                           id controller = _viewArray[_userSelectedChannelID - kTagOfTopButton];
                            if ([controller respondsToSelector:@selector(slideSwitchViewMadeToRefresh)]) {
                                [controller slideSwitchViewMadeToRefresh];
                            }
                        }
                    }];
                }
                _isRootScroll = NO;
                if (_lastSelectedChannelID != _userSelectedChannelID) {
                    _lastSelectedChannelID = _userSelectedChannelID;
                    if (_userSelectedChannelID-kTagOfTopButton >= _viewArray.count) {
                        return ;
                    }
                    
                    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - kTagOfTopButton];
                    }
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        // culiu fix bug
        _isRootScroll = NO;
    }
}


/**
 调整顶部滚动视图x位置

 @param sender 按钮
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float offset = sender.frame.origin.x + ceilf(sender.frame.size.width / 2.0f) - _topScrollView.bounds.size.width / 2.0f;
    if (offset < 0) {
        offset = 0;
    }
    else if (offset > (_topScrollView.contentSize.width - _topScrollView.bounds.size.width)) {
        offset = _topScrollView.contentSize.width - _topScrollView.bounds.size.width;
    }
    [_topScrollView setContentOffset:CGPointMake(offset, 0)  animated:YES];
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        int index = scrollView.contentOffset.x / self.width;
        _userContentOffsetX = index * self.width;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
        // title栏底下划线滑动时做实时拉伸效果,取滑动前button和滑动后button,来确定下划线的宽度
        if (!_isRootScroll) {
            return;
        }
       
        float offset = scrollView.contentOffset.x - _userContentOffsetX;
        int beforeTag = (int)_userContentOffsetX/self.bounds.size.width +kTagOfTopButton;
        UIButton *beforeButton = (UIButton *)[_topScrollView viewWithTag:beforeTag];
        int afterTag;
        if (!_isLeftScroll) {
            offset = offset * - 1;
            afterTag = beforeTag - 1;
        } else {
            afterTag = beforeTag + 1;
        }
        UIButton *afterButton = (UIButton *)[_topScrollView viewWithTag:afterTag];
        
        float scale = (float)offset/self.bounds.size.width;
        if (_isLeftScroll) {
            if (_shadowImageView.right >= beforeButton.right + afterButton.width) {
                [_shadowImageView setFrame:CGRectMake(afterButton.frame.origin.x, 0, afterButton.frame.size.width, kHeightOfTopScrollView)];
                CGSize textSize = [afterButton.titleLabel.text sizeWithFont:self.tabItemFont
                                                          constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                                              lineBreakMode:NSLineBreakByTruncatingTail];
                backgroundView.width = textSize.width;
                backgroundView.centerX = _shadowImageView.width / 2.0f;
            }
            _shadowImageView.right = beforeButton.right + scale * afterButton.width;
        } else {
            if (_shadowImageView.left <= beforeButton.left - afterButton.width) {
                [_shadowImageView setFrame:CGRectMake(afterButton.frame.origin.x, 0, afterButton.frame.size.width, kHeightOfTopScrollView)];
                CGSize textSize = [afterButton.titleLabel.text sizeWithFont:self.tabItemFont
                                                          constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                                              lineBreakMode:NSLineBreakByTruncatingTail];
                backgroundView.width = textSize.width;
                backgroundView.centerX = _shadowImageView.width / 2.0f;
            }
            _shadowImageView.left = beforeButton.left - scale * afterButton.width;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +kTagOfTopButton;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    //当滑道右边界时，传递滑动事件给代理
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - 工具方法


/**
 通过16进制计算颜色

 @param inColorString 颜色字符串
 @return 系统颜色类型
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (void)selectView:(NSInteger)index
{
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:index+kTagOfTopButton];
    [self selectNameButton:button];
}

@end
#pragma clang diagnostic pop
