//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXQuery.h"
#import "URXTerm.h"
#import "URXAPIError.h"
#import "URXSearchResult.h"
#import "URXAPIRequestHelper.h"
#import "URXAPIKey.h"
#import "URXSearchResponse.h"
#import "URXResolutionResponse.h"
@interface URXQueryIntegrationTests : XCTestCase

@end

@implementation URXQueryIntegrationTests

-(void)testSearch {
    setURXAPIKey(@"URX API Key goes here");
    URXSearchResponse *response = [[[URXTerm alloc] initWithKeywords:@"test"] searchSynchronously];
    if (response.error != nil) {
        XCTFail(@"Integration test couldn't resolve search request for query \"test\". Error: %@", response.error.errorMessage);
        return;
    }
    URXSearchResult *result = [response.results firstObject];
    
    URXResolutionResponse *resolutionResponse = [result resolveSynchronously];
    XCTAssert(resolutionResponse.error == nil, @"Integration test couldn't resolve resolution request for %@", result.urxResolutionUrl);
}

@end