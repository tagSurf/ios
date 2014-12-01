//
//  URXQuery.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

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
- (NSString *) queryString;
- (BOOL) equals:(URXQuery *)query;
- (void) searchAsynchronouslyWithSuccessHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;
- (URXSearchResponse *) searchSynchronously;

@end

#import "URXNot.h"
#import "URXSearchResponse.h"


























//URXQuery.h // Base query class, run searches from this (helper methods for "and" and "or" as well)
//URXAnd.h // Takes multiple queries and puts "AND"s between them
//URXOr.h // Takes multiple queries and puts "OR"s between them
//URXTerm.h // Keyword query
//URXPhrase.h // Phrase match query
//URXDomainFilter.h // <--
//URXActionFilter.h
//URXNot.h
//URXGroup.h
//URXRawQuery.h // Lets you enter in a string to use as a query, use at your own risk
//NSDictionary+JSONLD.h // Helper methods for NSDictionary which let you access values as a scalar or vector
//URXSearchResult.h // The schema.org "thing" (http://schema.org/Thing) properties (name, image(s), description, entityData (the JSONLD data for this response)), and different resolution options (web fallback, app store fallback, picker fallback)




