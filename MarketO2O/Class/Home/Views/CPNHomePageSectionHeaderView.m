//
//  CPNHomePageSectionHeaderView.m
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHomePageSectionHeaderView.h"

@interface CPNHomePageSectionHeaderView ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong)UISearchBar *searchBar;

@end

@implementation CPNHomePageSectionHeaderView

/**
 标题显示的label

 @return label
 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CPNCommonLabel commonLabelWithTitle:@"标题"
                                                  textFont:CPNCommonFontFifteenSize
                                                 textColor:CPNCommonMaxDarkGrayColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = nil;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


#pragma mark - baseFunction

/**
 设置显示的标题

 @param title 标题
 */
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.titleLabel.width = self.width;
    self.titleLabel.centerY = self.height/2;
}


/**
 返回组头高度

 @return 组头高度
 */
+ (CGFloat)sectionHeaderHeight{
    return 40;
}

@end
