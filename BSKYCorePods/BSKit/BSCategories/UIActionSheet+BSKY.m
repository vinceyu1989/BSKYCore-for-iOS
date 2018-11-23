//
//  UIActionSheet+Block.m
//  LinfengYU
//
//  Created by LinfengYU on 14-8-26.
//  Copyright (c) 2014年 FinderStudio. All rights reserved.
//

#import "UIActionSheet+BSKY.h"
#import <objc/runtime.h>

@implementation UIActionSheet (BSKY)

- (void)setCompletionBlock:(FSActionSheetCompletionBlock)completionBlock
{
	objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY);
	if (completionBlock == NULL) {
		self.delegate = nil;
	} else {
		self.delegate = self;
	}
}

- (FSActionSheetCompletionBlock)completionBlock
{
	return objc_getAssociatedObject(self, @selector(completionBlock));
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (self.completionBlock) {
		self.completionBlock(self, buttonIndex);
	}
}

@end
