//
//  CPNSignatureNameViewController.h
//  MarketO2O
//
//  Created by phh on 2017/9/3.
//  Copyright © 2017年 Maket. All rights reserved.
//
#import "CPNBaseViewController.h"

typedef void (^SignatureNameCompleteBlock)(UIImage *signatureImage);

@interface CPNSignatureNameViewController : CPNBaseViewController

- (id)initWithCompleteBlock:(SignatureNameCompleteBlock)block;

@end
