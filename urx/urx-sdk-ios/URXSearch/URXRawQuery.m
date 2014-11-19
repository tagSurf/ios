//  Copyright (c) 2014 URX. All rights reserved.

#import "URXRawQuery.h"

@interface URXRawQuery()

@property (strong,nonatomic,readonly) NSString *rawQuery;

@end

@implementation URXRawQuery

@synthesize rawQuery = _rawQuery;

-(instancetype)initWithQueryString:(NSString *)queryString
{
    if (self = [super init]) {
        _rawQuery = queryString;
    }
    return self;
}

-(NSString *)queryString
{
    if (self.rawQuery == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", self.rawQuery];

}

+(instancetype)queryFromString:(NSString *)queryString {
    return [[URXRawQuery alloc] initWithQueryString:queryString];
}

@end
