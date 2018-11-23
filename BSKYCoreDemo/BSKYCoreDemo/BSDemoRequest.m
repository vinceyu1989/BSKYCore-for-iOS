//
//  BSDemoRequest.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/25.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSDemoRequest.h"

@implementation BSDemoRequest

- (NSString*)bs_requestUrl {
    return [NSString stringWithFormat:@"/doctor/v1/doctorPwdLogin?phone=%@&password=123456", self.phone];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return nil;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    NSDictionary* data = self.ret;
    [BSClientManager sharedInstance].userId = data[@"userId"];
    [BSClientManager sharedInstance].loginMark = data[@"loginMark"];
    [BSClientManager sharedInstance].regCode = data[@"regCode"];
    [BSClientManager sharedInstance].tokenId = data[@"token"];
    [BSClientManager sharedInstance].lastUsername = self.phone;
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}
@end
