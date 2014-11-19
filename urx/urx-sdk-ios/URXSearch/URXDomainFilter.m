//  Copyright (c) 2014 URX. All rights reserved.

#import "URXDomainFilter.h"

@implementation URXDomainFilter

-(instancetype) initWithDomain:(NSString *)domain
{
    return [super initWithType:@"domain" andValue:domain];
}

+(instancetype)domainWithPLD:(NSString *)pld {
    return [[self alloc] initWithDomain:pld];
}

@end
