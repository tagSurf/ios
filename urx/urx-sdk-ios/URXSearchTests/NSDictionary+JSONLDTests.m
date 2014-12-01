//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "NSDictionary+JSONLD.h"

@interface NSDictionary_JSONLDTests : XCTestCase

@end

@implementation NSDictionary_JSONLDTests

- (void)testGetManyWithScalar
{
    NSDictionary *d = @{@"key": @"value"};
    NSArray *a = [d getMany: @"key"];
    XCTAssertTrue([a isEqualToArray:@[@"value"]], @"GetMany does not turn single value into array");
}

- (void)testGetManyWithVector
{
    NSArray *testArray = @[@"value1",@"value2"];
    NSDictionary *d = @{@"key": testArray};
    NSArray *a = [d getMany: @"key"];
    XCTAssertTrue([a isEqualToArray:testArray], @"GetMany should preserve vector");
}

- (void)testGetManyWithNil
{
    NSDictionary *d = @{};
    NSArray *a = [d getMany: @"key"];
    XCTAssertTrue([a isEqualToArray:@[]], @"GetMany should return empty array");
}

- (void)testGetSingleWithScalar
{
    NSDictionary *d = @{@"key": @"value"};
    NSString *s = [d getSingle: @"key"];
    XCTAssertTrue([s isEqualToString:@"value"], @"GetSingle does not return scalar values as they are.");
}

- (void)testGetSingleWithVector
{
    NSArray *testArray = @[@"value1",@"value2"];
    NSDictionary *d = @{@"key": testArray};
    NSString *s = [d getSingle: @"key"];
    XCTAssertTrue([s isEqualToString: @"value1"], @"GetSingle should return first value in vector");
}

- (void)testGetSingleWithNil
{
    NSDictionary *d = @{};
    id s = [d getSingle: @"key"];
    XCTAssertTrue(s == nil, @"GetSingle should return nil");
}
@end
