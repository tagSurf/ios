//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXLimit.h"

@interface URXLimitTests : XCTestCase

@end

@implementation URXLimitTests

-(void)testLimit
{
    URXLimit *limit = [URXLimit limitWithValue:5];
    XCTAssertTrue([@"limit:5" isEqualToString:[limit queryString]], @"Limit should return a query string with the set value");
}

@end

