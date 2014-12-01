//  Copyright (c) 2014 URX. All rights reserved.

#import "URXKeywordContext.h"

@implementation UILabel (URXKeywordContext)
-(NSString *)keywords {
    return self.text;
}
@end

@implementation UIButton (URXKeywordContext)
-(NSString *)keywords {
    return self.titleLabel.text;
}
@end

@implementation UISegmentedControl (URXKeywordContext)
-(NSString *)keywords {
    return [self titleForSegmentAtIndex:self.selectedSegmentIndex];
}
@end

@implementation UITextField (URXKeywordContext)
-(NSString *)keywords {
    return self.text;
}
@end

@implementation UITextView (URXKeywordContext)
-(NSString *)keywords {
    return self.text;
}
@end

@implementation UINavigationBar (URXKeywordContext)
-(NSString *)keywords {
    return self.topItem.title;
}
@end

@implementation UINavigationItem (URXKeywordContext)
-(NSString *)keywords {
    return self.title;
}
@end

@implementation UISearchBar (URXKeywordContext)
-(NSString *)keywords {
    return self.text;
}
@end