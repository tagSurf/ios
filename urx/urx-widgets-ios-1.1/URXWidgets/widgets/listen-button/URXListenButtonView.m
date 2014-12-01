//  Copyright (c) 2014 URX. All rights reserved.

#import "URXListenButtonView.h"
#import "URXListenButtonSearchViewController.h"

@interface UIView (ViewController)
- (UIViewController *) viewController;
- (id) _getViewController;
@end

@implementation UIView (ViewController)
- (UIViewController *) viewController {
    return (UIViewController *)[self _getViewController];
}

- (id) _getViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder _getViewController];
    } else {
        return nil;
    }
}
@end

@interface URXListenButtonView()

-(void)setupButton;
-(void)buttonPressed;

@end

@implementation URXListenButtonView

@synthesize initialQuery=_initialQuery;

-(instancetype)init {
    if (self = [super init]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

-(void)setupButton {
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonPressed {
    NSString *query = self.initialQuery;
    if (self.keywordContext) {
        NSString *keywordContext = [self.keywordContext keywords];
        if (keywordContext != nil) {
            query = keywordContext;
        }
    }
    
    URXListenButtonSearchViewController *modalViewController = [[URXListenButtonSearchViewController alloc] initWithInitialQuery:query modalBarColor:self.modalBarColor modalBarTitle:self.modalBarText modalBarTextColor:self.modalBarTextColor backButtonText:self.backButtonText backButtonColor:self.backButtonColor backButtonBoldText:self.backButtonBoldText andCallingViewController:[self viewController]];
    [[self viewController] presentViewController:modalViewController animated:YES completion:nil];
}

@end
