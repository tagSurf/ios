//  Copyright (c) 2014 URX. All rights reserved.

#import "URXLimit.h"

@implementation URXLimit

-(instancetype) initWithValue:(int) limitValue {
    return [super initWithType:@"limit" andValue:[NSString stringWithFormat:@"%i", limitValue]];
}

+(instancetype) limitWithValue:(int) limitValue {
    return [[URXLimit alloc] initWithValue:limitValue];
}

@end
