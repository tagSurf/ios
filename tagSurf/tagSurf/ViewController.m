//
//  ViewController.m
//  tagSurf
//
//  Created by Kieran Farrar on 6/19/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import "ViewController.h"
#import <URXSearch/URXSearchResult.h>

@interface ViewController ()
    
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://staging.tagsurf.co/share/trending/0"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView loadRequest:urlRequest];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
 -(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == 0) {
        NSString *requestedURL = request.URL.absoluteString;
        if(!([requestedURL rangeOfString:@"tagsurf" options:NSCaseInsensitiveSearch].location == NSNotFound)) return YES;
        else if(!([requestedURL rangeOfString:@"urx.io" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            URXSearchResult *result = [URXSearchResult searchResultFromEntityData:@{@"potentialAction":@{@"target":@{@"urlTemplate":requestedURL}}}];
            [result resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *resolutionError) {
                // log error if resolution fails
                NSLog(@"%@", resolutionError);
            }];
            return NO;
        }
        else {
            if (webView == self.visibleWebView) {
                [self.hiddenWebView loadRequest:request];
                [UIView animateWithDuration:duration animations:^{
                    // put an animation here
                } completion:^(BOOL finished) {
                    UIWebView *oldVisibleWebView = self.visibleWebView;
                    self.visibleWebView = self.hiddenWebView;
                    self.hiddenWebView = oldVisibleWebView;
                }];
                return NO;
            }
            return YES;
//            UIApplication *application = [UIApplication sharedApplication];
//            [application openURL:request.URL];
//            return NO;
        }
    }
    else return YES;
}
@end


