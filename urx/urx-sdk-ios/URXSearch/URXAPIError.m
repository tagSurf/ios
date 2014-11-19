//  Copyright (c) 2014 URX. All rights reserved.

#import "URXAPIError.h"

NSString * urxAPIErrorMessage(URXErrorType errorType){
    switch (errorType) {
        case URXNetworkConnectionError:
            return @"There was a network connection error connecting to the URX API.";
            break;
            
        case URXBadRequestError:
            return @"The request going to the URX API was bad.";
            break;
            
        case URXForbiddenError:
            return @"The URX API will not allow you to execute this request, maybe your API Key is not valid?";
            break;
            
        case URXQueryNotAcceptableError:
            return @"The query to be executed by the API is unacceptable.";
            break;
            
        case URXNoSearchResultsError:
            return @"No search results found for the requested query.";
            break;
            
        case URXDestinationNotFoundError:
            return @"The intended destination was not found by the URX API.";
            break;
            
        case URXLinkGoneError:
            return @"The intended destination no longer exists.";
            break;
            
        case URXRateLimitedError:
            return @"This API key is being rate limited by the URX API.";
            break;
            
        case URXServerError:
            return @"The URX API is currently unavailable.";
            break;
            
        case URXJSONParsingError:
            return @"The JSON being returned by the API is unparsable.";
            break;
            
        case URXUnknownError:
            return @"An unknown error has occurred with the URX Search SDK.";
            break;
    }
}

@implementation URXAPIError

@synthesize errorType=_errorType;
@synthesize request=_request;
@synthesize response=_response;
@synthesize error=_error;
@synthesize data=_data;

-(instancetype) initWithErrorType:(URXErrorType)errorType request:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error data:(NSData *)data {
    if (self = [super init]) {
        _errorType = errorType;
        _request = request;
        _response = response;
        _error = error;
        _data = data;
    }
    return self;
}

-(NSString *)errorMessage {
    return urxAPIErrorMessage(self.errorType);
}

@end