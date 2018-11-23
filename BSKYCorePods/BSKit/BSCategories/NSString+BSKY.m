//
//  NSString+BSKY.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "NSString+BSKY.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BSKY)

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)MD5String_16 {
    NSString* str = [self MD5String];
    
    return [str substringWithRange:NSMakeRange(8, 16)];
}

@end
