//  Copyright (c) 2014 URX. All rights reserved.

#import <Foundation/Foundation.h>

@interface URXDeepLinkResolutionHelper : NSObject

+(void)launchDeeplink:(NSString *)deeplink withFallbackHandler:(void (^)())fallbackHandler;

@end
