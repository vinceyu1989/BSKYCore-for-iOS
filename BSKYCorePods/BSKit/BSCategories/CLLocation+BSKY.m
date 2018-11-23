//
//  CLLocation+Equal.m
//  LinfengYU
//
//  Created by LinfengYU on 16/1/21.
//  Copyright © 2016年 Entropy. All rights reserved.
//

#import "CLLocation+BSKY.h"

@implementation CLLocation (BSKY)

- (BOOL)equalTo:(CLLocation *)location
{
	if (self && location) {
        if ([self distanceFromLocation:location] < 0.001) {
            return YES;
        }
	}

	return NO;
}

@end
