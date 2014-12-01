//
//  URXDateFilter.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXFilter.h"

@interface URXDateFilter : URXFilter

-(instancetype) initWithDate:(NSDate *)date;
-(instancetype) initWithStartDate:(NSDate *)startDate AndEndDate:(NSDate *)endDate;

@end
