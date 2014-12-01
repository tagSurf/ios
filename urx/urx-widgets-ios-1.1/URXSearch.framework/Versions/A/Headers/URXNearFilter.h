//
//  URXNearFilter.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXFilter.h"
#import <CoreLocation/CoreLocation.h>

@interface URXNearFilter : URXFilter

-(instancetype) initWithLocationString:(NSString *)locationString;
-(instancetype) initWithLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude;
-(instancetype) initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
