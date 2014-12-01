//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXTerm.h"
#import "URXAnd.h"

@interface URXAndTests : XCTestCase

@end

@implementation URXAndTests

-(void)testAnd
{
    URXTerm *term1 = [[URXTerm alloc] initWithKeywords:@"cat"];
    URXTerm *term2 = [[URXTerm alloc] initWithKeywords:@"dog"];
    URXAnd *and = [[URXAnd alloc] initWithLeftQuery:term1 andRightQuery:term2];
    NSString *expected = [NSString stringWithFormat:@"%@ AND %@", [term1 queryString], [term2 queryString]];
    XCTAssertTrue([expected isEqualToString:[and queryString]], @"URXAnd should put two terms together with an AND in between");
}

-(void)testAndOneValue
{
    URXTerm *term1 = [[URXTerm alloc] initWithKeywords:@"cat"];
    URXAnd *and = [[URXAnd alloc] initWithLeftQuery:term1 andRightQuery:nil];
    NSString *expected = [term1 queryString];
    XCTAssertTrue([expected isEqualToString:[and queryString]], @"URXAnd should return the query string with one value provided");
}

-(void)testAndNilValue
{
    URXAnd *and = [[URXAnd alloc] initWithLeftQuery:nil andRightQuery:nil];
    NSString *expected = @"";
    XCTAssertTrue([expected isEqualToString:[and queryString]], @"URXAnd should return an empty string");
}
@end
