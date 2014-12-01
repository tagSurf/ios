//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXTerm.h"
#import "URXGroup.h"

@interface URXGroupTests : XCTestCase

@end

@implementation URXGroupTests

- (void)testSingleValueGroup {
    URXTerm *v = [[URXTerm alloc]initWithKeywords:@"hello"];
    URXGroup *g = [[URXGroup alloc] initWithQueries:@[v]];
    XCTAssertTrue([[g queryString] isEqualToString:@"(hello)"], @"Didn't group a single value properly.");
    
}

- (void)testNoValueGroup {
    URXGroup *g = [[URXGroup alloc] initWithQueries:@[]];
    XCTAssertTrue([[g queryString] isEqualToString:@"()"], @"Didn't return parenthesis for no value");
}

- (void)testMultipleValueGroup {
    URXTerm *v = [[URXTerm alloc]initWithKeywords:@"hello"];
    URXTerm *v2 = [[URXTerm alloc]initWithKeywords:@"there"];
    URXGroup *g = [[URXGroup alloc] initWithQueries:@[v,v2]];
    XCTAssertTrue([[g queryString] isEqualToString:@"(hello there)"], @"Didn't group multiple values properly.");
}

-(void)testNilGroup {
    URXGroup *g = [[URXGroup alloc] initWithQueries:nil];
    XCTAssertTrue([@"" isEqualToString:[g queryString]], @"Nil array of queries in group should return an empty string");
}

@end
