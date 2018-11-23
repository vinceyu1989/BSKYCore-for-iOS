//
//  BSKYCoreDemoTests.m
//  BSKYCoreDemoTests
//
//  Created by Apple on 2017/7/21.
//  Copyright © 2017年 ky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSCategories.h"

@interface BSKYCoreDemoTests : XCTestCase

@end

@implementation BSKYCoreDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    CLLocation* l1 = [[CLLocation alloc] initWithLatitude:30.30 longitude:120.20];
    CLLocation* l1 = [[CLLocation alloc] initWithLatitude:30.67 longitude:104.06];
    CLLocation* l2 = [[CLLocation alloc] initWithLatitude:30.67 longitude:104.06];
    BOOL b = [l1 equalTo:l2];
    
    NSAssert(b, @"相等");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
