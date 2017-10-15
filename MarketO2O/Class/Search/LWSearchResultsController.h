//
//  SearchResultsController.h
//  LWSearchBarController
//
//  Created by liwei on 2016/4/18.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNBaseViewController.h"
#import "CPNHomePageProductItemModel.h"

@class LWSearchResultsController;
@protocol LWSearchResultsControllerDelegate <NSObject>

@optional

@end

@interface LWSearchResultsController : CPNBaseViewController<UISearchResultsUpdating>

- (void)updateSearchResults:(NSArray<CPNHomePageProductItemModel *> *)productions;

@end
