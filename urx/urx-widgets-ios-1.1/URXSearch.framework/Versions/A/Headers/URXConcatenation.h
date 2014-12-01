//
//  URXConcatenation.h
//  URXSearch
//
//  Created by James Turner on 10/8/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXQuery.h"

@interface URXConcatenation : URXQuery

-(instancetype) initWithConcatenationString:(NSString *)concatenationString leftQuery:(URXQuery *)leftQuery andRightQuery:(URXQuery *)rightQuery;

@end
