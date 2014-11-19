//  Copyright (c) 2014 URX. All rights reserved.

#import "URXGroup.h"

@interface URXGroup()

@property (strong, nonatomic, readonly) NSArray *queries;

@end

@implementation URXGroup

-(instancetype) initWithQueries:(NSArray *)queries {
    if (self = [super init]) {
        _queries = queries;
    }
    return self;
}

- (NSString *)queryString {
    if (self.queries == nil) {
        return @"";
    }
    NSMutableString *acc = [[NSMutableString alloc] init];
    [self.queries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *format;
        if (idx == 0) {
            format = @"%@";
        } else {
            format = @" %@";
        }
        [acc appendFormat:format, [obj queryString]];
    }];
    return [NSString stringWithFormat:@"(%@)", acc];
}

+(instancetype)groupQueries:(NSArray *)queries {
    return [[self alloc] initWithQueries:queries];
}

@end
