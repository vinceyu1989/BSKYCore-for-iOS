//
//  UIView+BSKY.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "UIView+BSKY.h"

@implementation UIView (BSKY)

- (UIViewController *)findViewController
{
    id target=self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (void)pulse {
    CABasicAnimation* pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= NO;
    pulse.fromValue= [NSNumber numberWithFloat:0.85];
    pulse.toValue= [NSNumber numberWithFloat:1];
    [self.layer addAnimation:pulse forKey:nil];
}

@end
