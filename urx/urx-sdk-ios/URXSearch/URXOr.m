//  Copyright (c) 2014 URX. All rights reserved.

#import "URXOr.h"

@implementation URXOr

-(instancetype) initWithLeftQuery:(URXQuery *)leftQuery andRightQuery:(URXQuery *)rightQuery {
    return [super initWithConcatenationString:@"OR" leftQuery:leftQuery andRightQuery:rightQuery];
}

@end
