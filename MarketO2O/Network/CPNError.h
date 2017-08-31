//
//  CPNError.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CPNErrorType){
    /**
     *  数据解析失败
     */
    CPNErrorTypeDataParaseError = -99999,
    /**
     *  网络错误
     */
    CPNErrorTypeNetworkError = -99998,
    /**
     *  数据为空
     */
    CPNErrorTypeDataIsBlink = -99997,
    /**
     *  服务不可用
     */
    CPNErrorTypeServerNotAvailable = -99996,
};


#define CPNErrorMessageDataParaseError @"数据解析错误"
#define CPNErrorMessageNetWorkError @"网络连接错误"
#define CPNErrorMessageServerError @"服务器异常"
#define CPNErrorMessageDataIsBlink @"数据为空"


@interface CPNError : NSObject

@property(nonatomic,assign)CPNErrorType     errorCode;
@property(nonatomic,copy  )NSString         *errorMessage;

@end
