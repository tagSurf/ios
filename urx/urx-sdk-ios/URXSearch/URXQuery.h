//  Copyright (c) 2014 URX. All rights reserved.

#import <Foundation/Foundation.h>
#import "URXAPIError.h"

@class URXAnd;
@class URXOr;
@class URXNot;
@class URXSearchResponse;

@interface URXQuery : NSObject

- (URXAnd *) and:(URXQuery *)query;
- (URXOr *) or:(URXQuery *)query;
- (URXNot *) not;
- (URXQuery *) paginateWithLimit:(int)limit andOffset:(int)offset;
- (NSString *) queryString;
- (BOOL) equals:(URXQuery *)query;
- (void) searchAsynchronouslyWithSuccessHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;
- (URXSearchResponse *) searchSynchronously;

@end

#import "URXNot.h"
#import "URXSearchResponse.h"