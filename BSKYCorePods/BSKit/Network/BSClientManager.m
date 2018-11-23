//
//  BSClientManager.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSClientManager.h"
#import "BSCategories.h"
#import <YYCategories/YYCategories.h>
#import <SAMKeychain/SAMKeychain.h>
#import "sys/utsname.h"

@interface BSClientManager ()

@end

@implementation BSClientManager

+ (instancetype)sharedInstance {
    static BSClientManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
        sharedInstance.version = currentAppVersion;
        sharedInstance.clientKey = @"1234567890123456";
        sharedInstance.gIv = @"bskyapp123456789";
    });
    return sharedInstance;
}

- (void)setClientKey:(NSString *)clientKey {
    [SAMKeychain setPassword:clientKey forService:@"BS_ClientKey" account:@"Current"];
}

- (NSString*)clientKey {
    return [SAMKeychain passwordForService:@"BS_ClientKey" account:@"Current"];
}

- (void)setUserId:(NSString *)userId {
    [SAMKeychain setPassword:userId forService:@"BS_UserId" account:@"Current"];
}

- (NSString*)userId {
    return [SAMKeychain passwordForService:@"BS_UserId" account:@"Current"];
}
- (void)setLoginMark:(NSString *)loginMark
{
    [SAMKeychain setPassword:loginMark forService:@"BS_LoginMark" account:@"Current"];
}
- (NSString *)loginMark
{
    return [SAMKeychain passwordForService:@"BS_LoginMark" account:@"Current"];
}

- (void)setTokenId:(NSString *)tokenId {
    [SAMKeychain setPassword:tokenId forService:@"BS_TokenId" account:@"Current"];
}

- (NSString*)tokenId {
    return [SAMKeychain passwordForService:@"BS_TokenId" account:@"Current"];
}

- (void)setVersion:(NSString *)version {
    [SAMKeychain setPassword:version forService:@"BS_Version" account:@"Current"];
}

- (NSString*)version {
    return [SAMKeychain passwordForService:@"BS_Version" account:@"Current"];
}

- (void)setRegCode:(NSString *)regCode {
    [SAMKeychain setPassword:regCode forService:@"BS_RegCode" account:self.userId];
}

- (NSString*)regCode {
    return [SAMKeychain passwordForService:@"BS_RegCode" account:self.userId];
}

- (void)setCek:(NSString *)cek {
    NSString* key = [NSString stringWithFormat:@"%@%@", self.userId, self.clientKey];
    [SAMKeychain setPassword:cek forService:@"BS_CEK" account:key];
}

- (NSString*)cek {
    NSString* key = [NSString stringWithFormat:@"%@%@", self.userId, self.clientKey];
    return [SAMKeychain passwordForService:@"BS_CEK" account:key];
}

- (void)setLastUsername:(NSString *)lastUsername {
    [SAMKeychain setPassword:lastUsername forService:@"BS_LastUsername" account:@"Current"];
}

- (NSString*)lastUsername {
    return [SAMKeychain passwordForService:@"BS_LastUsername" account:@"Current"];
}

- (NSInteger)nonce {
    NSDate* now = [NSDate date];
    return (NSInteger)[now timeIntervalSince1970] * 1000;
}
- (NSString*)rek {
    NSString* str = [NSString stringWithFormat:@"%@%@%@", self.regCode, self.clientKey, self.loginMark];
    return [str MD5String_16];
}

- (NSString*)clientAgent {
    return [NSString stringWithFormat:@"%@ %@/%.0f*%.0f", [self deviceName], [UIDevice currentDevice].systemVersion, kScreenWidth, kScreenHeight];
}

- (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

- (id)headMode {
    NSInteger nonce = [BSClientManager sharedInstance].nonce;
    NSDictionary* dic = @{
                           @"category": @"2",
                           @"imei": @"",
                           @"imsi": @"",
                           @"phonetype": [self deviceName],
                           @"reqDigest": @"",
                           @"timestamp": [NSString stringWithFormat:@"%ld", (long)nonce],
                           @"loginMark": self.loginMark ? self.loginMark : @"",
                           @"version": self.version
                           };
    NSMutableDictionary *json = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *string = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",json[@"version"],json[@"loginMark"],json[@"timestamp"],json[@"imsi"],json[@"phonetype"],json[@"imei"],json[@"category"],self.clientKey];
    NSString *reqDigest = [[string MD5String] base64EncodedString];
    [json setObject:reqDigest forKey:@"reqDigest"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableString* s = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] mutableCopy];
    
    return [s stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

@end
