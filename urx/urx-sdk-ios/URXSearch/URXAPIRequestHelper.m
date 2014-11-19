//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>
#import "URXAPIRequestHelper.h"
#import "URXAPIKey.h"

@implementation URXAPIRequestHelper

+(NSString *)userAgentString {
    return [NSString stringWithFormat:@"urx-client/%@ (ios; %@)", URX_SEARCH_SDK_VERSION, [[UIDevice currentDevice] systemVersion]];
}

+(NSMutableURLRequest *) requestWithURL:(NSString *)url {
    NSString *apiKey = urxAPIKey();
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:url]];
    
    //Set HTTP Method type
    [request setHTTPMethod:@"GET"];
    
    //Set Accept Header
    [request setValue:@"application/ld+json"
   forHTTPHeaderField:@"Accept"];

    //Set User-Agent
    [request setValue:[self userAgentString]
   forHTTPHeaderField:@"User-Agent"];
    
    //set API-Key
    [request setValue:apiKey
   forHTTPHeaderField:@"X-API-Key"];
    
    return request;
}

+(NSString *) searchURLWithQueryString:(NSString *)queryString {
    return [NSString stringWithFormat:@"%@%@", URX_API_BASE_URL, [self uriEncode:queryString]];
}

+(NSString *) uriEncode:(NSString *)toEncode {
    return [toEncode stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

@end