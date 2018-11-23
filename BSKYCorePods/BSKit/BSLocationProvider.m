//
//  BSLocationProvider.m
//  LinfengYU
//
//  Created by LinfengYU on 14/12/15.
//  Copyright (c) 2014年 aladdin. All rights reserved.
//

#import "BSLocationProvider.h"
#import "CLLocation+BSKY.h"
#import <UIKit/UIKit.h>

#define BSKYLastLatitude    @"BSKYLastLatitude"
#define BSKYLastLongitude   @"BSKYLastLongitude"

@interface BSLocationProvider ()<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation BSLocationProvider

+ (BSLocationProvider *)sharedInstance
{
	static BSLocationProvider *sharedInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		sharedInstance = [[self alloc] init];

        if (sharedInstance.cacheEnable) {
            double latitude = [[[NSUserDefaults standardUserDefaults]
                                objectForKey:BSKYLastLatitude] doubleValue];
            double longitude = [[[NSUserDefaults standardUserDefaults]
                                 objectForKey:BSKYLastLongitude] doubleValue];
            CLLocation* loc = [[CLLocation alloc] initWithLatitude:latitude
                                                         longitude:longitude];
            sharedInstance.currentLocation = loc;
        }
        
		[sharedInstance initLocation];
	});

	return sharedInstance;
}

- (void)initLocation
{
	if (!self.locationManager) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		self.locationManager.distanceFilter = 5.0;
	}
}

- (void)startLocation
{
	if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
		[self.locationManager startUpdatingLocation];
	} else {
	}
}

- (void)stopLocation
{
	[self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	self.currentLocation = newLocation;

	double latitude = self.currentLocation.coordinate.latitude;
	double longitude = self.currentLocation.coordinate.longitude;
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", latitude] forKey:BSKYLastLatitude];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", longitude] forKey:BSKYLastLongitude];

	if (self.locationUpdateBlock) {
		self.locationUpdateBlock(self.currentLocation);
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	self.locationServiceAvailable = YES;
	CLLocation *location = [locations lastObject];
	if (self.currentLocation && [self.currentLocation equalTo:location]) {
		return;
	}

	self.currentLocation = [locations lastObject];

	double latitude = self.currentLocation.coordinate.latitude;
	double longitude = self.currentLocation.coordinate.longitude;
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", latitude] forKey:BSKYLastLatitude];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", longitude] forKey:BSKYLastLongitude];

	if (self.locationUpdateBlock) {
		self.locationUpdateBlock(self.currentLocation);
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	self.locationServiceAvailable = NO;
}

@end
