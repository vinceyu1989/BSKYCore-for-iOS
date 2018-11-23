//
//  BSBaseRequest.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSBaseRequest.h"
#import "BSClientManager.h"
#import "AES128Helper.h"
#import <objc/runtime.h>
#import "BSNetConfig.h"

@interface BSBaseRequest ()

@end

@implementation BSBaseRequest

- (NSString*)requestUrl {
    NSString *pattern = @"";
    switch ([BSNetConfig sharedInstance].type) {
        case SeverType_Dev:
            pattern = @"bsky-app-dev";
            break;
        case SeverType_Test:
            pattern = @"bsky-app-test";
            break;
        case SeverType_Release:
            pattern = @"bsky-app";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@%@", pattern, [self bs_requestUrl]];
}

- (NSString*)bs_requestUrl {
    return nil;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(NSTimeInterval)requestTimeoutInterval {
    return 60;
}

- (NSDictionary*)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json",
             @"headMode": [[BSClientManager sharedInstance] headMode],
             @"token": [BSClientManager sharedInstance].tokenId};
}

- (void)requestCompleteFilter {
    _code = -1;
    _msg = @"没有数据";
    
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.responseObject;
        _msg = dic[@"msg"];
        if (dic[@"code"]) {
            _code =  ((NSString *)dic[@"code"]).integerValue;
        }
        // 数据解密
        id data = dic[@"data"];
        if (!data || [data isKindOfClass:[NSNull class]]) {
            _ret = [NSDictionary dictionary];
        }
        else if ([data isKindOfClass:[NSString class]])
        {
            // 取消加密
            //            NSString* jsonString = [AES128Helper AES128DecryptCBC:data key:[BSClientManager sharedInstance].cek gIv:[BSClientManager sharedInstance].gIv];
            //            if (!jsonString) {
            //                jsonString = [AES128Helper AES128DecryptText:data key:[BSClientManager sharedInstance].cek];
            //            }
            //            if ([data length] > 0 && jsonString.length <= 0) {
            //                jsonString = data;
            //            }
            //            if (jsonString) {
            //                NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            //                NSError* error = nil;
            //                id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            //                if (obj != nil && error == nil) {
            //                    _ret = obj;
            //                }
            //            }else {
            //                _ret = dic[@"data"];
            //            }
            
            NSData* dd = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError* error = nil;
            id obj = [NSJSONSerialization JSONObjectWithData:dd options:NSJSONReadingAllowFragments error:&error];
            if (obj != nil && error == nil) {
                _ret = obj;
            }
        }
        else
        {
            _ret = data;
        }
    }
    if (self.code != 200) {
        self.successCompletionBlock = nil;
        if (self.failureCompletionBlock) {
            self.failureCompletionBlock(self);
        }
    }
}

-(void)requestFailedFilter {
    _code = -1;
    _msg = @"没有数据";
    if (self.responseObject && [self.responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.responseObject;
        _msg = dic[@"msg"];
        if (dic[@"code"]) {
            _code =  ((NSString *)dic[@"code"]).integerValue;
        }
    }else if (self.error) {
        _msg = self.error.localizedDescription;
        _code = self.error.code;
    }
}

- (id)requestArgument {
    return nil;
}

-(BOOL)ignoreCache {
    return YES;
}

@end
