//
//  BSBaseRequest.h
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

@interface BSBaseRequest : YTKRequest

@property (nonatomic, strong, readonly) NSString *msg;

@property (nonatomic, assign, readonly) NSInteger code;

@property (nonatomic, strong, readonly) id ret;

- (NSString*)bs_requestUrl;

@end
