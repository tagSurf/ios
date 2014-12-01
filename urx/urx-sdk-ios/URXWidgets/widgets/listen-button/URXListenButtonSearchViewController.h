//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>

@interface URXListenButtonSearchViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

-(instancetype)initWithInitialQuery:(NSString *)initialQuery modalBarColor:(UIColor *)modalBarColor modalBarTitle:(NSString *)modalBarTitle modalBarTextColor:(UIColor *)modalBarTextColor backButtonText:(NSString *)backButtonText backButtonColor:(UIColor *)backButtonColor backButtonBoldText:(BOOL)backButtonBoldText andCallingViewController:(UIViewController *)callingViewController;

@end
