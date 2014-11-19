//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>
#import "URXQuery.h"
#import "URXAPIError.h"
#import "URXAPIRequestHelper.h"
#import "URXSearchResult.h"
#import "URXAnd.h"
#import "URXOr.h"
#import "URXLimit.h"
#import "URXOffset.h"
#import "URXRawQuery.h"

@interface URXQuery()

-(void)handleSearchResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request data:(NSData *)data error:(NSError *)error successHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;

@end

@implementation URXQuery

- (URXAnd *) and:(URXQuery *)query {
    return [[URXAnd alloc] initWithLeftQuery:self andRightQuery:query];
}
- (URXOr *) or:(URXQuery *)query{
    return [[URXOr alloc] initWithLeftQuery:self andRightQuery:query];
}
- (URXNot *) not {
    return [URXNot notQuery:self];
}

- (URXQuery *) paginateWithLimit:(int)limit andOffset:(int)offset {
    return [URXRawQuery queryFromString:[NSString stringWithFormat:@"%@ %@ %@", [self queryString], [[URXLimit limitWithValue:limit] queryString], [[URXOffset offsetWithValue:offset] queryString]]];
}

- (NSString *) queryString {
    return @"";
}
- (BOOL) equals:(URXQuery *)query {
    return [[self queryString] isEqualToString:[query queryString]];
}

- (NSString *)description {
    return [self queryString];
}

- (void) searchAsynchronouslyWithSuccessHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler {
    
    NSURLRequest *request = [URXAPIRequestHelper requestWithURL:[URXAPIRequestHelper searchURLWithQueryString:[self queryString]]];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         [self handleSearchResponse:((NSHTTPURLResponse *)response) request:request data:data error:error successHandler:successHandler andFailureHandler:failureHandler];
     }];
}

- (URXSearchResponse *) searchSynchronously {
    NSURLRequest *request = [URXAPIRequestHelper requestWithURL:[URXAPIRequestHelper searchURLWithQueryString:[self queryString]]];
    NSHTTPURLResponse *r;
    NSError *e;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&r error:&e];
    __block URXSearchResponse *toReturn;
    __block URXAPIError *apiError;
    [self handleSearchResponse:r request:request data:data error:e successHandler:^(URXSearchResponse *a) {
        toReturn = a;
    } andFailureHandler:^(URXAPIError *err) {
        apiError = err;
        toReturn = [[URXSearchResponse alloc] initWithError:err];
    }];
    return toReturn;
}

-(void)handleSearchResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request data:(NSData *)data error:(NSError *)error successHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler {
    
    URXAPIError *(^makeError)(URXErrorType)= ^URXAPIError *(URXErrorType e) {
        return [[URXAPIError alloc] initWithErrorType:e request:request response:response error:error data:data];
    };
    
    //If the HTTP Request gave us an error or we didn't get any data, fail
    if (error != nil || [data length] == 0){
        failureHandler(makeError(URXNetworkConnectionError));
        return;
    }
    
    //Check status codes for errors
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    switch (httpResponse.statusCode) {
        case 200:
        case 300:
            break;
            
        case 400:
            failureHandler(makeError(URXBadRequestError));
            return;
            break;
            
        case 403:
            failureHandler(makeError(URXForbiddenError));
            return;
            break;
            
        case 404:
            failureHandler(makeError(URXNoSearchResultsError));
            return;
            break;
            
        case 406:
        case 422:
            failureHandler(makeError(URXQueryNotAcceptableError));
            return;
            break;
            
        case 410:
            failureHandler(makeError(URXLinkGoneError));
            return;
            break;
            
        case 429:
            failureHandler(makeError(URXRateLimitedError));
            return;
            break;
            
        case 500:
        case 502:
        case 503:
        case 504:
            failureHandler(makeError(URXServerError));
            return;
            break;

        default:
            failureHandler(makeError(URXUnknownError));
            return;
            break;
    }
    
    NSDictionary *responseJSON = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:0
                                  error:&error];
    if (error != nil) {
        failureHandler(makeError(URXJSONParsingError));
        return;
    }
    successHandler([[URXSearchResponse alloc] initWithEntityData:responseJSON]);
}

@end

