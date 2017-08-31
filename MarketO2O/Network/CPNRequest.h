//
//  CPNRequest.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

extern NSString * const CPN_REQUEST_METHOD_GET;
extern NSString * const CPN_REQUEST_METHOD_POST;
extern NSString * const CPN_REQUEST_METHOD_PUT;
extern NSString * const CPN_REQUEST_METHOD_DELETE;

@interface CPNRequest : NSObject {
    
@protected
    NSString            *_requestMethod;
    NSString            *_requestPath;
    NSMutableDictionary *_requestBody;
    NSMutableArray      *_pictureDataArr;
}


@property (nonatomic,readwrite,copy  ) NSString            *requestMethod;
@property (nonatomic,readwrite,copy  ) NSString            *requestPath;
@property (nonatomic,readwrite,strong) NSMutableDictionary *requestBody;
@property (nonatomic,readwrite,strong) NSData              *pictureData;
@property (nonatomic,readwrite,strong) NSMutableArray      *pictureDataArr;
@property (nonatomic,readwrite,copy  ) NSString            *requestImageKey;


- (NSArray *)allKeys;
- (NSArray *)allValues;

- (NSString*)stringForKey:(NSString*)key;
- (NSInteger)intForKey:(NSString*)key;
- (double)doubleForKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;
- (NSDate*)dateForKey:(NSString*)key;
- (NSDate*)dateForKey:(NSString*)key withFormat:(NSString*)format;
- (NSData*)dataForKey:(NSString*)key;

- (void)setString:(NSString*)value forKey:(NSString*)key;
- (void)setInt:(NSInteger)value forKey:(NSString*)key;
- (void)setDouble:(double)value forKey:(NSString*)key;
- (void)setBool:(BOOL)value forKey:(NSString*)key;
- (void)setDate:(NSDate*)value forKey:(NSString*)key;
- (void)setDate:(NSDate*)value forKey:(NSString*)key withFormat:(NSString*)format;
- (void)setData:(NSData*)value forKey:(NSString*)key;
- (void)setImageData:(NSData *)value forKey:(NSString *)key;

- (void)setArray:(NSArray *)array forKey:(nonnull NSString *)key;

@end

#pragma clang diagnostic pop

