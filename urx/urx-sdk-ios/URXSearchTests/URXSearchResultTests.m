//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "URXSearchResult.h"

@interface URXSearchResultTests : XCTestCase

@end

@implementation URXSearchResultTests

- (void)testDefensiveImageAccessorWithURLString {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":imageUrl}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImageAccessorWithImageObjectAndContentUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@{@"contentUrl":imageUrl}}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImageAccessorWithImageObjectAndEmbedUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@{@"embedUrl":imageUrl}}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImageAccessorWithImageObjectAndUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@{@"url":imageUrl}}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImageAccessorWithImageObjectAndEmbedUrlFromVector {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[@{@"embedUrl":imageUrl}]}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImagesAccessorWithURLString {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[imageUrl]}];
    XCTAssert([[[r imagesUrl] firstObject] isEqualToString:imageUrl]);
}

- (void)testDefensiveImagesAccessorWithImageObjectAndContentUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[@{@"contentUrl":imageUrl}]}];
    XCTAssert([[[r imagesUrl] firstObject] isEqualToString:imageUrl]);
}

- (void)testDefensiveImagesAccessorWithImageObjectAndEmbedUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[@{@"embedUrl":imageUrl}]}];
    XCTAssert([[[r imagesUrl] firstObject] isEqualToString:imageUrl]);
}

- (void)testDefensiveImagesAccessorWithImageObjectAndUrl {
    NSString *imageUrl = @"http://example.com/image.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[@{@"url":imageUrl}]}];
    XCTAssert([[r imageUrl] isEqualToString:imageUrl]);
}

- (void)testDefensiveImagesAccessorWithMultipleImages {
    NSString *image1 = @"http://example.com/image1.png";
    NSString *image2 = @"http://example.com/image2.png";
    NSString *image3 = @"http://example.com/image3.png";
    NSString *image4 = @"http://example.com/image4.png";
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"image":@[@{@"url":image1},image2,@{@"contentUrl":image3},@{@"embedUrl":image4}]}];
    XCTAssert([[[r imagesUrl] objectAtIndex:0] isEqualToString:image1]);
    XCTAssert([[[r imagesUrl] objectAtIndex:1] isEqualToString:image2]);
    XCTAssert([[[r imagesUrl] objectAtIndex:2] isEqualToString:image3]);
    XCTAssert([[[r imagesUrl] objectAtIndex:3] isEqualToString:image4]);
}

@end
