//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXRawQuery.h"

@interface URXRawQueryTests : XCTestCase

@end

@implementation URXRawQueryTests

-(void)testRawQuery {
    NSString *keywords = @"chicago bulls";
    URXRawQuery *rawQuery = [[URXRawQuery alloc] initWithQueryString:keywords];
    XCTAssertTrue([keywords isEqualToString:[rawQuery queryString]], @"The rawQuery does not equal the string provided to it");
}

-(void)testNilRawQuery {
    URXRawQuery *rawQuery = [[URXRawQuery alloc] initWithQueryString:nil];
    XCTAssertTrue([@"" isEqualToString:[rawQuery queryString]], @"Nil raw query string should produce an empty string");
}

@end
