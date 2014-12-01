//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXOr.h"
#import "URXTerm.h"

@interface URXOrTests : XCTestCase

@end

#import "URXActionFilter.h"
#import "URXDomainFilter.h"

@implementation URXOrTests

-(void)testOr
{
    URXTerm *term1 = [[URXTerm alloc] initWithKeywords:@"cat"];
    URXTerm *term2 = [[URXTerm alloc] initWithKeywords:@"dog"];
    URXOr *or = [[URXOr alloc] initWithLeftQuery:term1 andRightQuery:term2];
    NSString *expected = [NSString stringWithFormat:@"%@ OR %@", [term1 queryString], [term2 queryString]];
    XCTAssertTrue([expected isEqualToString:[or queryString]], @"URXAnd should put two terms together with an OR in between");
}

-(void)testOrOneValue
{
    URXTerm *term1 = [[URXTerm alloc] initWithKeywords:@"cat"];
    URXOr *or = [[URXOr alloc] initWithLeftQuery:term1 andRightQuery:nil];
    NSString *expected = [term1 queryString];
    XCTAssertTrue([expected isEqualToString:[or queryString]], @"URXOr should return the query string with one value provided");
}

-(void)testOrNilValue
{
    URXOr *or = [[URXOr alloc] initWithLeftQuery:nil andRightQuery:nil];
    NSString *expected = @"";
    XCTAssertTrue([expected isEqualToString:[or queryString]], @"URXOr should return an empty string");
}

@end

