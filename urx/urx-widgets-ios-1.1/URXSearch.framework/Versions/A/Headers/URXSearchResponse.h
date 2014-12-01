//
//  URXSearchResponse.h
//  URXSearch
//
//  Created by James Turner on 10/8/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXAPIError.h"

@interface URXSearchResponse : NSObject

@property (strong, nonatomic, readonly) NSDictionary *entityData;
@property (strong, nonatomic, readonly) NSArray *results;
@property (strong, nonatomic, readonly) URXAPIError *error;

-(instancetype) initWithEntityData:(NSDictionary *)entityData;
-(instancetype) initWithError:(URXAPIError *)error;

@end
