//
//  URXDate.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"
#import "URXRangeableValue.h"

@interface URXDate : URXQuery<URXRangeableValue>

-(instancetype) initWithDate:(NSDate *)date;

@end
