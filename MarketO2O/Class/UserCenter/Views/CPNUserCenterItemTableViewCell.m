//
//  CPNUserCenterItemTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNUserCenterItemTableViewCell.h"


@interface CPNUserCenterItemTableViewCell ()

/**
 按钮icon显示的imageView
 */
@property (nonatomic, strong) UIImageView   *iconImageView;

/**
 按钮标题显示的label
 */
@property (nonatomic, strong) UILabel       *titleLabel;

@end

@implementation CPNUserCenterItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


#pragma mark - loadView

/**
 按钮icon显示的imageView

 @return imageView
 */
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"全部订单icon"]];
        [_iconImageView sizeToFit];
        _iconImageView.left = 15;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}


/**
 按钮标题显示的label

 @return label
 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CPNCommonLabel commonLabelWithTitle:@"全部订单"
                                                  textFont:CPNCommonFontFifteenSize
                                                 textColor:CPNCommonMiddleBlackColor];
        _titleLabel.text = nil;
        _titleLabel.numberOfLines = 1;
        _titleLabel.left = self.iconImageView.right + 10;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}


#pragma mark - baseFunction

/**
 刷新坐标
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.centerY = self.height/2;
    self.titleLabel.centerY = self.height/2;
    self.titleLabel.width = self.contentView.width - self.titleLabel.left - 10;
}

/**
 设置icon图片名称

 @param iconName 图片名称
 */
- (void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
}


/**
 设置标题

 @param title 标题
 */
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}


/**
 返回cell高度

 @return cell高度
 */
+ (CGFloat)cellHeight{
    return 45;
}


@end
