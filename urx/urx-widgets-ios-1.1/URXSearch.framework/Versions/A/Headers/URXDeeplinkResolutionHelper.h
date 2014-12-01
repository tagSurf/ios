//
//  URXDeepLinkResolutionHelper.h
//  URXSearch
//
//  Created by James Turner on 9/9/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URXDeepLinkResolutionHelper : NSObject

+(void)launchDeeplink:(NSString *)deeplink withFallbackHandler:(void (^)())fallbackHandler;

@end
