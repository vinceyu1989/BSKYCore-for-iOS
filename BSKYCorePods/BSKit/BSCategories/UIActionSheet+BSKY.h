//
//  UIActionSheet+Block.h
//  LinfengYU
//
//  Created by LinfengYU on 14-8-26.
//  Copyright (c) 2014年 FinderStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FSActionSheetCompletionBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex);

@interface UIActionSheet (BSKY)<UIActionSheetDelegate>

@property (nonatomic, copy) FSActionSheetCompletionBlock completionBlock;

@end
