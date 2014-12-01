//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXOffset.h"

@interface URXOffsetTests : XCTestCase

@end

@implementation URXOffsetTests

-(void)testOffset
{
    URXOffset *offset = [URXOffset offsetWithValue:4];
    XCTAssertTrue([@"offset:4" isEqualToString:[offset queryString]], @"Offset should return a query string with the set value");
}

@end


