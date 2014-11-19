//  Copyright (c) 2014 URX. All rights reserved.

#import "URXResolutionResponse.h"
#import "URXAPIError.h"

@interface URXSearchResult : NSObject

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *imageUrl;
@property (nonatomic,readonly) NSArray *imagesUrl;
@property (nonatomic,readonly) NSString *descriptionText;
@property (nonatomic,readonly) NSString *callToActionText;
@property (nonatomic,readonly) NSString *urxResolutionUrl;
@property (strong,nonatomic,readonly) NSDictionary *entityData;

+(instancetype) searchResultFromEntityData:(NSDictionary *)entityData;

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;

-(URXResolutionResponse *) resolveSynchronously;

@end
