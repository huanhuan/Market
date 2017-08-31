//
//  CPNPointsMarketCategoryTableViewCell.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNPointsMarketCategoryTableViewCell.h"
#import "CPNPointsMarketCategoryModel.h"

@interface CPNPointsMarketCategoryTableViewCell ()

/**
 类别名称显示的label
 */
@property (nonatomic, strong) UILabel   *titleLabel;

@end

@implementation CPNPointsMarketCategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CPNCommonContrllorBackgroundColor;
    }
    return self;
}


#pragma mark - loadView

/**
 类别名称显示的label

 @return label
 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [CPNCommonLabel commonLabelWithTitle:@"水果"
                                                  textFont:CPNCommonFontFifteenSize
                                                 textColor:CPNCommonMaxDarkGrayColor];
        _titleLabel.text = nil;
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


#pragma mark - baseFunction

/**
 刷新坐标
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.size = self.size;
}


/**
 设置数据model

 @param categoryModel 类别model
 */
- (void)setCategoryModel:(CPNPointsMarketCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    self.titleLabel.text = categoryModel.name;
    if (categoryModel.isSelected) {
        self.backgroundColor = CPNCommonWhiteColor;
    }else{
        self.backgroundColor = CPNCommonContrllorBackgroundColor;
    }
}


/**
 返回行高

 @return 行高
 */
+ (CGFloat)cellHeight{
    return 50;
}



@end
