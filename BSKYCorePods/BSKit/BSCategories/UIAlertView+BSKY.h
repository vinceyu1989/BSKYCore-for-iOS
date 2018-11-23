//
//  UIAlertView+BSKY.h
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCompletionBlock)(UIAlertView* alertView, NSInteger index);

@interface UIAlertView (BSKY)

@property (nonatomic, copy) UIAlertViewCompletionBlock completionBlock;

@end
