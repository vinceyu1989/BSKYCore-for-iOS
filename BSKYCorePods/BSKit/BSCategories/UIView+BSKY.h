//
//  UIView+BSKY.h
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSKY)

/**
 找到该页面的Controller
 */
- (UIViewController *)findViewController;

/**
 点击效果的动画
 */
- (void)pulse;

@end
