//  Copyright (c) 2014 URX. All rights reserved.

#import "URXDeeplinkResolutionHelper.h"
#import <UIKit/UIKit.h>

@implementation URXDeepLinkResolutionHelper

+(void)launchDeeplink:(NSString *)deeplink withFallbackHandler:(void (^)())fallbackHandler {
    NSURL *deeplinkURL = [NSURL URLWithString:deeplink];
    
    if ([[UIApplication sharedApplication] canOpenURL:deeplinkURL]) {
        [[UIApplication sharedApplication] openURL:deeplinkURL];
    } else {
        fallbackHandler();
    }
}

@end
