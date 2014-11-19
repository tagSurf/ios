//  Copyright (c) 2014 URX. All rights reserved.

#import "URXConcatenation.h"

@interface URXConcatenation()

@property (nonatomic,strong,readonly) NSString *concatenationString;
@property (nonatomic,strong,readonly) URXQuery *leftQuery;
@property (nonatomic,strong,readonly) URXQuery *rightQuery;


@end

@implementation URXConcatenation

@synthesize concatenationString=_concatenationString;
@synthesize leftQuery=_leftQuery;
@synthesize rightQuery=_rightQuery;

-(instancetype) initWithConcatenationString:(NSString *)concatenationString leftQuery:(URXQuery *)leftQuery andRightQuery:(URXQuery *)rightQuery {
    if (self = [super init]) {
        _concatenationString = concatenationString;
        _leftQuery = leftQuery;
        _rightQuery = rightQuery;
    }
    return self;
}

-(NSString *)queryString
{
    BOOL leftEmpty = self.leftQuery == nil || [[self.leftQuery queryString] isEqualToString:@""];
    BOOL rightEmpty = self.rightQuery == nil || [[self.rightQuery queryString] isEqualToString:@""];
    
    if (leftEmpty && rightEmpty) {
        return @"";
    }
    if (leftEmpty) {
        return [self.rightQuery queryString];
    }
    if (rightEmpty) {
        return [self.leftQuery queryString];
    }
    return [NSString stringWithFormat:@"%@ %@ %@", self.leftQuery, self.concatenationString, self.rightQuery];
}

@end
