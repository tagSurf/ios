//
//  URXAPIRequestHelper.h
//  URXSearch
//
//  Created by James Turner on 9/9/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URX_API_BASE_URL @"https://beta.urx.io/"
#define URX_SEARCH_SDK_VERSION @"0.1"

@interface URXAPIRequestHelper : NSObject

+(NSMutableURLRequest *) requestWithURL:(NSString *)url;
+(NSString *) searchURLWithQueryString:(NSString *)queryString;
+(NSString *) uriEncode:(NSString *)toEncode;

@end