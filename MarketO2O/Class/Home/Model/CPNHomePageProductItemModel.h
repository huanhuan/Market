//
//  CPNHomePageGoodsItemModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNHomePageProductItemModel : CPNBaseModel

@property (nonatomic, copy) NSString    *id;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *desc;
@property (nonatomic, copy) NSString    *imageUrl;
@property (nonatomic, assign) long      points;
@property (nonatomic, copy) NSString    *categoryId;
@property (nonatomic, copy) NSString    *shopId;
@property (nonatomic, copy) NSString    *typeId;
@property (nonatomic, copy) NSString    *star;
@property (nonatomic, assign) NSInteger status;

//详情图片
@property (nonatomic, strong)NSArray<NSString *> *detailImageUrls;


@end
