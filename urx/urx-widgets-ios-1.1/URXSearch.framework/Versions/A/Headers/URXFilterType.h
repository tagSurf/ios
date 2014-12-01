//
//  URXFilterType.h
//  URXSearch
//
//  Created by Chris Sell on 9/5/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URXFilterType : NSEnumerator

-(instancetype)initWithRepr:(NSString *)repr;
-(NSString *)queryString;

@end
