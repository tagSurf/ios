//  Copyright (c) 2014 URX. All rights reserved.

#import "URXSearchResult.h"
#import "NSDictionary+JSONLD.h"
#import "URXAPIRequestHelper.h"
#import "URXResolutionResponse.h"
#import "URXDeeplinkResolutionHelper.h"
#import "URXAPIError.h"

@interface URXSearchResult()

-(instancetype) initWithEntityData:(NSDictionary *)entityData;

@end

@implementation URXSearchResult

@synthesize entityData = _entityData;

+(instancetype) searchResultFromEntityData:(NSDictionary *)entityData
{
    return [[self alloc] initWithEntityData:entityData];
}

-(instancetype) initWithEntityData:(NSDictionary *)entityData {
    if (self = [super init]) {
        _entityData = entityData;
    }
    return self;
}

-(NSString *)name {
    id name = [self.entityData getSingle:@"name"];
    if ([name isKindOfClass:[NSNull class]] || ![name isKindOfClass:[NSString class]]) {
        return nil;
    }
    return (NSString *)name;
}

-(NSString *)imageUrl {
    id image = [self.entityData getSingle:@"image"];
    if ([image isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([image isKindOfClass:[NSString class]]) {
        return image;
    }
    if([image isKindOfClass:[NSDictionary class]]) {
        if ([[image getSingle:@"contentUrl"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"contentUrl"];
        }
        if ([[image getSingle:@"embedUrl"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"embedUrl"];
        }
        if ([[image getSingle:@"url"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"url"];
        }
    }
    return nil;
}

-(NSArray *)imagesUrl {
    id images = [self.entityData getMany:@"image"];
    NSMutableArray *imagesToReturn = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(id image, NSUInteger idx, BOOL *stop) {
        if ([image isKindOfClass:[NSString class]]) {
            [imagesToReturn addObject:image];
        }
        if([image isKindOfClass:[NSDictionary class]]) {
            if ([[image getSingle:@"contentUrl"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"contentUrl"]];
            }
            if ([[image getSingle:@"embedUrl"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"embedUrl"]];
            }
            if ([[image getSingle:@"url"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"url"]];
            }
        }
    }];
    return [imagesToReturn copy];
}

-(NSString *)descriptionText {
    id description = [self.entityData getSingle:@"description"];
    if ([description isKindOfClass:[NSNull class]] || ![description isKindOfClass:[NSString class]]) {
        return nil;
    }
    return (NSString *)description;
}

-(NSString *)callToActionText {
    id potentialAction = [self.entityData getSingle:@"potentialAction"];
    if (potentialAction == nil || ![potentialAction isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id actionType = [potentialAction getSingle:@"@type"];
    if (potentialAction == nil || ![potentialAction isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSString *actionTypeString = (NSString *)actionType;
    return [actionTypeString substringToIndex:([actionTypeString length] - [@"Action" length])];
}

-(NSString *)urxResolutionUrl {
    return [URX_API_BASE_URL stringByAppendingString:[URXAPIRequestHelper uriEncode:[[[[self.entityData getSingle:@"potentialAction"] getSingle:@"target"] getSingle:@"urlTemplate"] stringByReplacingOccurrencesOfString:@"https://urx.io/" withString:@""]]];
}

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler{
    NSMutableURLRequest *request = [URXAPIRequestHelper requestWithURL:self.urxResolutionUrl];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         [self handleResolutionResponse:(NSHTTPURLResponse *)response request:request data:data error:error successHandler:successHandler andFailureHandler:failureHandler];
     }];
}

-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler {
    [self resolveAsynchronouslyWithSuccessHandler:^(URXResolutionResponse *r) {
        if (![r launchDeeplink]) {
            [r launchInBrowser];
        }
    } andFailureHandler:failureHandler];
}

-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler {
    [self resolveAsynchronouslyWithSuccessHandler:^(URXResolutionResponse *r) {
        if (![r launchDeeplink]) {
            if (![r launchInAppStore]) {
                [r launchInBrowser];
            }
        }
    } andFailureHandler:failureHandler];
}

-(void) handleResolutionResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request data:(NSData *)data error:(NSError *)error successHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler {
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
            failureHandler(makeError(URXDestinationNotFoundError));
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
            break;
    }
    
    NSDictionary *responseJSON = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:0
                                  error:&error];
    URXResolutionResponse *resolutionResponse = [URXResolutionResponse resolutionResponseWithEntityData:responseJSON];
    successHandler(resolutionResponse);
}

-(URXResolutionResponse *) resolveSynchronously {
    NSMutableURLRequest *request = [URXAPIRequestHelper requestWithURL:self.urxResolutionUrl];
    
    NSHTTPURLResponse *response;
    NSError *e;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];
    
    __block URXResolutionResponse *resolutionResponse;
    
    [self handleResolutionResponse:response request:request data:data error:e successHandler:^(URXResolutionResponse *r) {
        resolutionResponse = r;
    } andFailureHandler:^(URXAPIError *err) {
        resolutionResponse = [URXResolutionResponse resolutionResponseWithError:err];
    }];
    
    return resolutionResponse;
}

-(NSString *)description {
    return [self.entityData description];
}

@end