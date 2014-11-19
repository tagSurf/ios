//  Copyright (c) 2014 URX. All rights reserved.

#import "NSDictionary+JSONLD.h"

@implementation NSDictionary (JSONLD)


-(NSArray *)getMany:(NSString *)key
{
    if (self[key] == nil)
    {
        return [NSArray array];
    } else if ([self[key] isKindOfClass:[NSArray class]])
    {
        return self[key];
    } else {
        return [NSArray arrayWithObject:self[key]];
    }
}

-(id)getSingle:(NSString *)key
{
    if (self[key] == nil)
    {
        return nil;
    } else if ([self[key] isKindOfClass:[NSArray class]])
    {
        return self[key][0];
    } else {
        return self[key];
    }
}

@end
