//
//  ViewController.m
//  BSKYCoreDemo
//
//  Created by Apple on 2017/7/21.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "ViewController.h"
#import "BSCategories.h"
#import "BSClientManager.h"
#import "BSDemoRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    [self demoAES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)demoAES {
    NSString* str = @"test string";
    NSString* key = @"1234567890123456";
    
    NSString* encryptText = [AES128Helper AES128EncryptText:str key:key];
    NSString* decryptText = [AES128Helper AES128DecryptText:encryptText key:key];
    
    NSLog(@"加密字符串:%@", str);
    NSLog(@"加密密钥:%@", key);
    NSLog(@"加密后:%@", encryptText);
    NSLog(@"解密后:%@", decryptText);
}

- (IBAction)onRegCode:(id)sender {
    
    [BSClientManager sharedInstance].userId = @"";
    BSDemoRequest* q = [BSDemoRequest new];
    q.phone = @"15680854323";
    [q startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
