//
//  CATLocationProvider.h
//  LinfengYU
//
//  Created by LinfengYU on 14/12/15.
//  Copyright (c) 2014年 aladdin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface BSLocationProvider : NSObject

@property (nonatomic, assign) BOOL locationServiceAvailable;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, copy) void (^locationUpdateBlock)(CLLocation *location);
@property (nonatomic, assign) BOOL cacheEnable;

+ (BSLocationProvider *)sharedInstance;

- (void)startLocation;

- (void)stopLocation;

@end
