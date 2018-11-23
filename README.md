[TOC]

# BSKYCore for iOS

​	巴蜀快医客户端有`医生端`和`居民端`，在iOS端的项目开发中在`BSKYDoctorPro for iOS`和`BSKYResideng for iOS`进行开发和管理。`BSYKCore for iOS`项目将给`BSKYDoctorPro for iOS`和`BSKYResideng for iOS`提供基础模块的封装和通用的业务逻辑封装。

​	`BSKYCore for iOS`由两部分组成**BSKit**和**BSLib**。**BSKit**封装巴蜀快医业务相关的逻辑，例如*字体*、*颜色*、*Http Header 处理*等。**BSLib**封装业务无关的基础类库和算法，例如*AES算法*、*网络请求*、*容器安全*、*线程池管理*等。

## 项目地址

`码云` https://git.oschina.net/bskyios/BSKYCore-for-iOS.git

## 项目结构

#### BSLib
* Thread Pool
* AES-128-EBC encrypt
* Collection Safe Tools
#### BSKit

* Sevaral Categories
* BSLocationProvider
* BSBaseRequest
* RegCode and License
* BSRouter

## 交流协作

* 如果发现**bug**，请在项目中开一个issue
* 如果有新的**需求**，请在项目中开一个issue
* 如果要提供代码，请提交一个pull request
* 有其他疑问请联系`164205295@qq.com`

## 使用CocoaPods安装

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking). You can install it with the following command:

```
$ gem install cocoapods
```

#### Podfile

```objective-c
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'BSKYCore', '~> 0.1.3'
end
```

Then, run the following command:

```objective-c
$ pod install
```
执行`pod search BSKYCore`如果搜索不到请先执行`pod setup`

## 开始使用

你需要在项目中`#import <BSKYCore/BSKit.h>`和`#import <BSKYCore/BSLib.h>`

#### 客户端激活和获取证书

`CEK` 登录用户在与服务端进行交互的时候，服务端将对数据进行`AES-128-ECB`加密后返回给客户端，`CEK`为加密密钥，客户端在接收到数据后，需要对数据进行对称解密才能使用。

> 服务端返回的数据结构

```json
{
  "code": 200,
  "msg": "message from server",
  "data": "encrypt data"
}
```

用户在调用登录或者注册接口后，服务端将返回给客户端`uerId`，客户端需要立即发起激活请求

```objective-c
[BSClientManager autoLicenseWithUserId:userId succeed:^{
    // 授权成功
} failed:^(NSString *msg) {
    // 授权失败，提示用户并重试
}];
```

#### 创建网络请求

例如：请求获取用户信息

1. 配置网络请求参数

```objective-c
[BSNetConfig configWithType:SeverType_Test]; 	// 内网测试环境
```

2. 创建请求对象

```objective-c
// BSUserInfoRequest.h
@interface BSUserInfoRequest : BSBaseRequest
@property (nonatomic, copy) NSString *userId;		// 请求的参数
@end
```

```objective-c
// BSUserInfoRequest.m
@implementation BSUserInfoRequest

// 请求的URI
- (NSString*)requestUrl {
    return @"/bsky/auth/test";		
}

// Http method
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;		
}

// 请求参数
- (id)requestArgument {
    return @{@"userId": self.userId};	
}

// 请求成功之后的回调，请在这里讲NSDictionary或者NSArray对象转换成Model对象
- (void)requestCompleteFilter {
    [super requestCompleteFilter];	// BSBaseRequest中做了解密工作
    // self.ret => models
}

@end
```

3. 发起请求

```
BSUserInfoRequest* request = [BSUserInfoRequest new];
request.userId = @"100001";
[q startWithCompletionBlockWithSuccess:^(BSUserInfoRequest* request) {
    // 请求成功     
} failure:^(BSUserInfoRequest* request) {
    // 请求失败
}];
```

#### 页面路由

为了各个业务模块间的解耦，引入**BSRouter**，**BSRouter**中维护一个`url -> block`的注册表，相对独立的页面或者功能模块添加到工程后，需要在**BSRouter**中注册该模块对外开放的接口。

`router.h`客户端页面的路由管理文件，客户端在每次启动之后向服务器请求，并缓存或更新本地缓存，该文件保存页面路由的键值列表`UserModuleUserDetail -> bsky://userDetail/:uid`

> 场景模拟：在客户端首页`HomeViewController`点击按钮进入用户详情页面`UserDetailViewController`

1. 创建类`UserModule`，负责用户模块的接口注册，对外暴露用户模块的接口

 ```objective-c
 // UserModule.m
 @implementation UserModule
 + (void)load {
     [BSRouter registerURLPattern:UserModuleUserDetail toObjectHandler:^id(NSDictionary *routerParameters) {
         UserDetailViewController* viewController = [UserDetailViewController new];
         NSDictionary* userInfo = routerParameters[MGJRouterParameterUserInfo];
         viewController.uid = userInfo[@"uid"];
         return viewController;
     }];
 }
 @end
 ```

2. 在首页调用

 ```objective-c
 - (void)onDetail:(id)sender {
     UIViewController* detailViewController = [BSRouter objectForURL:UserModuleUserDetail withUserInfo:@{@"uid": @"123456"}];
     [self.navigationController pushViewController:detailViewController animated:YES];
 }
 ```

   

### 联系

`码云`LinfengYU

`邮箱`164205295@qq.com

`微信&QQ`164205295
