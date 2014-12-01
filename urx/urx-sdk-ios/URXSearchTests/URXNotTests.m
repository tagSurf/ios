//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXNot.h"
#import "URXTerm.h"

@interface URXNotTests : XCTestCase

@end

@implementation URXNotTests

-(void)testNot
{
    URXQuery *query = [[URXTerm alloc] initWithKeywords:@"chicago bulls"];
    URXNot *notQuery = [[URXNot alloc] initWithQuery:query];
    NSString *endQuery = [NSString stringWithFormat:@"NOT %@", [query queryString]];
    
    XCTAssertTrue([endQuery isEqualToString:[notQuery queryString]], @"Query not properly formatted with not");
}

-(void)testNilNot {
    URXNot *not = [[URXNot alloc] initWithQuery:nil];
    XCTAssertTrue([@"" isEqualToString:[not queryString]], @"Nil query passed to URXNot should produce an empty query string");
}

@end
