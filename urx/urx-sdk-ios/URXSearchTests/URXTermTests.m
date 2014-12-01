//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXTerm.h"

@interface URXTermTests : XCTestCase

@end

@implementation URXTermTests

-(void)testTerm {
    NSString *keywords = @"chicago bulls";
    URXTerm *term = [[URXTerm alloc] initWithKeywords:keywords];
    XCTAssertTrue([keywords isEqualToString:[term queryString]], @"The term query doesn't equal the string provided to it");
}

-(void)testNilTerm{
    URXTerm *term = [[URXTerm alloc] initWithKeywords:nil];
    XCTAssertTrue([@"" isEqualToString:[term queryString]], @"Nil values should become empty strings");
}

@end
