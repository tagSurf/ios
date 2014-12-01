//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXDomainFilter.h"

@interface URXDomainFilterTests : XCTestCase

@end

#import "URXTerm.h"

@implementation URXDomainFilterTests

-(void)testDomain
{
    NSString *domain = @"google.com";
    NSString *domainQuery = [NSString stringWithFormat:@"domain:%@", domain];
    URXDomainFilter *domainFilter = [[URXDomainFilter alloc] initWithDomain:domain];
    XCTAssertTrue([domainQuery isEqual:[domainFilter queryString]], @"DomainFilter should return domain as string");
}

-(void)testNilDomain
{
    NSString *domain = nil;
    URXDomainFilter *domainFilter = [[URXDomainFilter alloc] initWithDomain:domain];
    XCTAssertTrue([@"" isEqual:[domainFilter queryString]], @"DomainFilter should return empty string when given nil domain");
}

@end
