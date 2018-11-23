//
//  BSNetConfig.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "BSNetConfig.h"
#import "YTKNetwork.h"

@implementation BSNetConfig

+ (instancetype)sharedInstance {
    static BSNetConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
