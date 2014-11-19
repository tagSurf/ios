//  Copyright (c) 2014 URX. All rights reserved.

#import "URXFilter.h"

@interface URXFilter()

@property (strong,nonatomic,readonly) NSString *type;
@property (strong,nonatomic,readonly) id value;

@end

@implementation URXFilter

@synthesize type = _type;
@synthesize value = _value;

-(instancetype)initWithType:(NSString *)type andValue:(id)value
{
    if (self == [super init])
    {
        _type = type;
        _value = value;
    }
    return self;
}

-(NSString *)queryString
{
    if (self.type == nil || [[self.type stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || self.value == nil || [[self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        return @"";
    } else {
        NSString *value = self.value;
        return [NSString stringWithFormat:@"%@:%@", self.type, value];
    }
}

@end