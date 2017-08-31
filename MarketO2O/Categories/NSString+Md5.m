//
// Created by culiumac2 on 13-8-14.
// Copyright (c) 2013 culiu－mac01. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSString+Md5.h"


@implementation NSString (Md5)


-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

-(NSRange)rangeFromString:(NSString *)fromStr toString:(NSString *)toStr {
    NSRange range = NSMakeRange(0, 0);
    NSRange range1 = [self rangeOfString:fromStr];
    if (range1.location != NSNotFound) {
        NSString *nesStr = [self substringFromIndex:range1.location + range1.length];
        NSRange range2 = [nesStr rangeOfString:toStr];
        if (range2.location != NSNotFound) {
            range.location = range1.location + range1.length;
            range.length = range2.location;
        }
        
    }
    return range;
}


@end