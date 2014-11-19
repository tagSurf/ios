//  Copyright (c) 2014 URX. All rights reserved.

#import "URXAPIKey.h"

static NSString *__urxAPIKey;

NSString * urxAPIKey() {
    if (__urxAPIKey == nil) {
        NSString *apiKeyFromPList = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"URX API Key"];
        if (apiKeyFromPList != nil) {
            __urxAPIKey = apiKeyFromPList;
            return __urxAPIKey;
        }
    } else {
        return __urxAPIKey;
    }
    @throw [NSException exceptionWithName:@"No URX API Key Provided" reason:@"No API Key was provided to the URX Search SDK. API Key must be added to the app's plist file with the key \"URX API Key\" and your API key as the value." userInfo:nil];
    return nil;
}

void setURXAPIKey(NSString *apiKey) {
    __urxAPIKey = apiKey;
}