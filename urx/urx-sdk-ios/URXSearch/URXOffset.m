//  Copyright (c) 2014 URX. All rights reserved.

#import "URXOffset.h"

@implementation URXOffset

-(instancetype) initWithValue:(int) offsetValue {
    return [super initWithType:@"offset" andValue:[NSString stringWithFormat:@"%i", offsetValue]];
}

+(instancetype) offsetWithValue:(int) offsetValue {
    return [[URXOffset alloc] initWithValue:offsetValue];
}

@end
