//
//  BSClientManager.h
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSClientManager : NSObject

@property (nonatomic, copy) NSString *version;              // 客户端版本号
@property (nonatomic, copy) NSString *clientKey;            // 客户端内置密码
@property (nonatomic, copy) NSString *regCode;              // 客户端激活码
@property (nonatomic, copy) NSString *cek;                  // 内容加密密钥
@property (nonatomic, copy) NSString *userId;               // 用户注册/登录之后设置一下
@property (nonatomic, copy) NSString *loginMark;            // 登录标识符
@property (nonatomic, copy) NSString *tokenId;              // 用户注册/登录之后设置一下
@property (nonatomic, copy) NSString *gIv;                  // CBC 偏移量
@property (nonatomic, copy) NSString *lastUsername;         // 上次登录的用户名

+ (instancetype)sharedInstance;

- (NSInteger)nonce;

/**
 给CEK加密的密钥
 */
- (NSString*)rek;

/**
 设备名称
 */
- (NSString*)deviceName;

- (NSString*)clientAgent;

- (id)headMode;

@end
