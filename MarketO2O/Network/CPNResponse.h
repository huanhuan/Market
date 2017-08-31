//
//  CPNResponse.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPNError;
@class CPNResponse;

typedef void (^CPNHTTPCompleteBlock)(CPNResponse * response,CPNError * error);

@interface CPNResponse : NSObject

@property (nonatomic,assign) id             respBody;
@property (nonatomic,strong) NSString       *respMsg;
@property (nonatomic,assign) NSInteger      respCode;
@property (nonatomic,strong) CPNError       *error;

- (CPNResponse *)initWithResp:(id)resp
                        error:(NSError *)error
                  requestPath:(NSString *)requestPath;

@end
