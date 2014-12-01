//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXActionFilter.h"

@interface URXActionFilterTests : XCTestCase

@end

@implementation URXActionFilterTests

-(void)testActionFilter
{
    NSString *action = @"ListenAction";
    NSString *actionQuery = [NSString stringWithFormat:@"action:%@", action];
    URXActionFilter *actionFilter = [[URXActionFilter alloc] initWithAction:action];
    XCTAssertTrue([actionQuery isEqualToString:[actionFilter queryString]], @"ActionFilter should return a string");
}

-(void)testNilActionFilter
{
    URXActionFilter *actionFilter = [[URXActionFilter alloc] initWithAction:nil];
    XCTAssert([@"" isEqualToString:[actionFilter queryString]], @"ActionFilter should return an empty string when given nil");
}

@end
