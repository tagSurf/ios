//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>
#import "URXResolutionResponse.h"
#import "NSDictionary+JSONLD.h"

@implementation URXResolutionResponse

@synthesize entityData=_entityData;
@synthesize error=_error;

-(NSString *)deeplink {
    return self.entityData == nil ? nil : [self.entityData getSingle:@"urlTemplate"];
}

-(NSString *)appStoreUri {
    return self.entityData == nil ? nil : [[self.entityData getSingle:@"application"] getSingle:@"installUrl"];
}

-(NSString *)webUri {
    return self.entityData == nil ? nil : [self.entityData getSingle:@"sameAs"];
}

-(NSString *)appName {
    return self.entityData == nil ? nil : [[self.entityData getSingle:@"application"] getSingle:@"name"];
}

-(instancetype) initWithEntityData:(NSDictionary *)entityData {
    if (self = [super init]) {
        _entityData = entityData;
    }
    return self;
}

-(instancetype) initWithError:(URXAPIError *)error {
    if (self = [super init]) {
        _error = error;
    }
    return self;
}

+(instancetype) resolutionResponseWithEntityData:(NSDictionary *)entityData {
    return [[URXResolutionResponse alloc] initWithEntityData:entityData];
}

+(instancetype) resolutionResponseWithError:(URXAPIError *)error {
    return [[URXResolutionResponse alloc] initWithError: error];
}

-(BOOL) launchDeeplink {
    if (self.deeplink == nil) {
        return NO;
    }
    NSURL *deeplinkURL = [NSURL URLWithString:self.deeplink];
    if ([[UIApplication sharedApplication] canOpenURL:deeplinkURL]) {
        [[UIApplication sharedApplication] openURL:deeplinkURL];
        return YES;
    }
    return NO;
}

-(BOOL) launchInAppStore {
    if (self.appStoreUri == nil) {
        return NO;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreUri]];
    return YES;
}

-(BOOL) launchInBrowser {
    if (self.webUri == nil) {
        return NO;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.webUri]];
    return YES;
}

@end
