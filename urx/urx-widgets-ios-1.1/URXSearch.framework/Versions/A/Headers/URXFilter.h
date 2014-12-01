//
//  URXFilter.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

@interface URXFilter : URXQuery

-(instancetype) initWithType:(NSString *)filterType andValue:(id)value;

@end
