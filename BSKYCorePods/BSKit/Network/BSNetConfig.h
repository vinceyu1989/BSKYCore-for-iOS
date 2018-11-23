//
//  BSNetConfig.h
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger , SeverType){
    SeverType_Dev = 0,          // 开发地址
    SeverType_Test,             // 测试地址
    SeverType_Release,          // 发布地址
};

@interface BSNetConfig : NSObject

@property (nonatomic, assign) SeverType type;

+ (instancetype)sharedInstance;


@end
