//
//  URXPhrase.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

@interface URXPhrase : URXQuery

- (instancetype) initWithPhrase:(NSString *)phrase;
+ (instancetype) phraseWithString:(NSString *)string;

@end
