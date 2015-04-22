//
//  ViewController.h
//  tagSurf
//
//  Refactored by Paul Lacey on 12/01/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URXSearch/URXSearchResult.h>


@interface ViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *linkView;

- (void)loadURL:(NSString *)urlToLoad;

- (void)loadCard:(NSString *)tag cardID:(NSString *)cardID;

@end;
