//  Copyright (c) 2014 URX. All rights reserved.

#import "URXTerm.h"

@interface URXTerm()

@property (strong, nonatomic, readonly) NSString *text;

@end

@implementation URXTerm

@synthesize text=_text;

-(instancetype)initWithKeywords:(NSString *)keywords {
    if (self = [super init]) {
        _text = keywords;
    }
    return self;
}

-(NSString *)queryString {
    if (self.text == nil) {
        return @"";
    }
    return self.text;
}

+(instancetype)termWithKeywords:(NSString *)keywords{
    return [[self alloc] initWithKeywords:keywords];
}

@end
