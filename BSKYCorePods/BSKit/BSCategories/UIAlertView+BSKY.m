//
//  UIAlertView+BSKY.m
//  BSKYCoreDemo
//
//  Created by LinfengYU on 2017/7/24.
//  Copyright © 2017年 ky. All rights reserved.
//

#import "UIAlertView+BSKY.h"
#import <objc/runtime.h>

@implementation UIAlertView (BSKY)

- (void)setCompletionBlock:(void (^)(UIAlertView *, NSInteger))completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY);
    if (self.completionBlock) {
        self.delegate = self;
    }else {
        self.delegate = nil;
    }
}

- (UIAlertViewCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.completionBlock) {
        self.completionBlock(self, buttonIndex);
    }
}

@end
