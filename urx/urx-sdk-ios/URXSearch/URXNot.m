//  Copyright (c) 2014 URX. All rights reserved.

#import "URXNot.h"

@interface URXNot()

@property (strong,nonatomic,readonly) URXQuery *query;

@end

@implementation URXNot

@synthesize query = _query;

-(instancetype)initWithQuery:(URXQuery *)query
{
    if (self = [super init]) {
        _query = query;
    }
    return self;
}

-(NSString *)queryString {
    if (self.query == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"NOT %@", [self.query queryString]];

}

+(instancetype)notQuery:(URXQuery *)query{
    return [[self alloc] initWithQuery:query];
}

@end
