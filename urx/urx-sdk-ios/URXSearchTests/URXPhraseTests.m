//  Copyright (c) 2014 URX. All rights reserved.

#import <XCTest/XCTest.h>
#import "URXPhrase.h"

@interface URXPhraseTests : XCTestCase

@end

@implementation URXPhraseTests

- (void) testPhrase
{
    NSString *unquotedPhrase = @"chicago bulls";
    NSString *quoted = [NSString stringWithFormat:@"\"%@\"", unquotedPhrase];
    URXPhrase *phrase = [[URXPhrase alloc] initWithPhrase:unquotedPhrase];
    XCTAssertTrue([quoted isEqualToString:[phrase queryString]], @"The term query doesn't equal the string provided to it");
}

-(void)testNilTerm{
    URXPhrase *phrase = [[URXPhrase alloc] initWithPhrase:nil];
    XCTAssertTrue([@"" isEqualToString:[phrase queryString]], @"Nil values should become empty strings");
}

@end
