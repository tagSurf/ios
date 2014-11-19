//  Copyright (c) 2014 URX. All rights reserved.

#import "URXPhrase.h"

@interface URXPhrase()

@property (strong,nonatomic, readonly) NSString *text;

@end

@implementation URXPhrase

@synthesize text=_text;

- (instancetype)initWithPhrase:(NSString *)phrase
{
    if (self = [super init]) {
        _text = phrase;
    }
    return self;
}

-(NSString *)queryString {
    if (self.text == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"\"%@\"", self.text];
}

+(instancetype)phraseWithString:(NSString *)string {
    return [[self alloc] initWithPhrase:string];
}

@end
