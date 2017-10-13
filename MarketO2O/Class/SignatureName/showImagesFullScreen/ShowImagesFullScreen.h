//
//  ShowImagesFullScreen.h
//  RDM
//
//  Created by phh on 15/11/28.
//  Copyright © 2015年 phh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowImagesFullScreen : NSObject

+ (ShowImagesFullScreen*)shareShowImagesFullScreenManager;
- (void)showImages:(NSArray<UIImageView*>*)imageArray currentShowImageIndex:(NSUInteger)index;
@end
