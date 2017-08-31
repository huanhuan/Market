//
//  CPNRequest.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNRequest.h"

NSString * const CPN_REQUEST_METHOD_GET    = @"GET";
NSString * const CPN_REQUEST_METHOD_POST   = @"POST";
NSString * const CPN_REQUEST_METHOD_PUT    = @"PUT";
NSString * const CPN_REQUEST_METHOD_DELETE = @"DELETE";

@implementation CPNRequest

- (instancetype)init {
    if (self = [super init]) {
        _requestBody        = [[NSMutableDictionary alloc] init];
        _pictureDataArr     = [[NSMutableArray alloc] init];
        _requestMethod      = CPN_REQUEST_METHOD_POST;
        _requestPath        = @"";
    }
    return self;
}

- (NSArray *)allKeys {
    return [_requestBody allKeys];
}

- (NSArray *)allValues {
    return [_requestBody allValues];
}

- (void)setRequestPath:(NSString *)requestPath{
    _requestPath = [[requestPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark ------ getter --------

- (NSString*)stringForKey:(NSString*)key {
    return [_requestBody objectForKey:key];
}


- (NSInteger)intForKey:(NSString*)key {
    return [[self stringForKey:key] intValue];
}


- (double)doubleForKey:(NSString*)key {
    return [[self stringForKey:key] longLongValue];
}


- (BOOL)boolForKey:(NSString*)key {
    return [[self stringForKey:key] boolValue];
}


- (NSDate*)dateForKey:(NSString*)key {
    return [self dateForKey:key withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate*)dateForKey:(NSString*)key withFormat:(NSString*)format {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSDate* date = [df dateFromString:key];
    return date;
}

- (NSData*)dataForKey:(NSString*)key {
    return nil;
}

#pragma mark ------ setter --------

- (void)setString:(NSString*)value forKey:(NSString*)key {
    assert(key != nil);
    if (value == nil){
        [_requestBody removeObjectForKey:key];
    }
    else{
        [_requestBody setObject:value forKey:key];
    }
    
}


- (void)setInt:(NSInteger)value forKey:(NSString*)key {
    [self setString:[NSString stringWithFormat:@"%ld", (long)value] forKey:key];
}


- (void)setDouble:(double)value forKey:(NSString*)key {
    [self setString:[NSString stringWithFormat:@"%f", value] forKey:key];
}


- (void)setBool:(BOOL)value forKey:(NSString*)key {
    [self setString:(value == NO) ? @"0" : @"1" forKey:key];
}


- (void)setDate:(NSDate*)value forKey:(NSString*)key {
    [self setDate:value forKey:key withFormat:@"yyyy-MM-dd HH:mm:ss"];
}


- (void)setDate:(NSDate*)value forKey:(NSString*)key withFormat:(NSString*)format {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSString* dateStr = [[NSString alloc] initWithFormat:@"%@", [df stringFromDate:value]];
    [self setString:dateStr forKey:key];
}

- (void)setData:(NSData*)value forKey:(NSString*)key {
}


- (void)setImageData:(NSData *)value forKey:(NSString *)key {
    [_requestBody setObject:value forKey:key];
    self.pictureData = value;
    self.requestImageKey = key;
    
}


- (void)setArray:(NSArray *)array forKey:(nonnull NSString *)key {
    [_requestBody setObject:array forKey:key];
}


@end
