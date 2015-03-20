//
//  ViewController.m
//  tagSurf
//
//  Refactored by Paul Lacey on 12/01/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import "ViewController.h"
#import <URXSearch/URXSearchResult.h>
#import "UAPush.h"
#import <sys/utsname.h>

@interface ViewController ()
    
@end


NSString*
machineName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://beta.tagsurf.co/share/funny/0"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
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
    NSString *requestedURL = request.URL.absoluteString;


    if(navigationType == 0 || (navigationType == 5 && !([requestedURL rangeOfString:@"push" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch].location == NSNotFound))) {
        if(!([requestedURL rangeOfString:@"tagsurf" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            if(!([requestedURL rangeOfString:@"push-enable" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch].location == NSNotFound)) {
                
                NSString *user_id = [[requestedURL componentsSeparatedByString:@"/"] objectAtIndex:4];
                [UAPush shared].alias = user_id;
                [[UAPush shared] updateRegistration];
                [UAPush shared].userPushNotificationsEnabled = YES;
                return YES;
            }
            else if(!([requestedURL rangeOfString:@"push" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch].location == NSNotFound) &&
                    ([requestedURL rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch].location == NSNotFound)) {
                
                NSString *model = machineName();
                NSString *hash = [@"~" stringByAppendingString:model];
                NSString *newURL = [requestedURL stringByAppendingString:hash];
                NSURL *url = [NSURL URLWithString:newURL];
                NSURLRequest *newRequest = [NSURLRequest requestWithURL:url];
                [self.webView stopLoading];
                [self.webView loadRequest:newRequest];
                return YES;
            }
            else
                return YES;
        }
        else if(!([requestedURL rangeOfString:@"urx.io" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            URXSearchResult *result = [URXSearchResult searchResultFromEntityData:@{@"potentialAction":@{@"target":@{@"urlTemplate":requestedURL}}}];
            [result resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *resolutionError) {
//                 log error if resolution fails
                NSLog(@"%@", resolutionError);
            }];
            return NO;
        }
        else {
            [self.linkView loadRequest:request];
            self.linkView.scalesPageToFit = YES;
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBtn.frame = CGRectMake((self.view.frame.size.width - 55)/2, (self.view.frame.size.height - 32), 55, 32);
            [closeBtn setTitle:@"close" forState:UIControlStateNormal];
            [closeBtn setBackgroundColor:[UIColor lightGrayColor]];
            [closeBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.linkView addSubview:closeBtn];
            [self.view bringSubviewToFront:self.linkView];
//            UIApplication *application = [UIApplication sharedApplication];
//            [application openURL:request.URL];
            return NO;
        }
    }
    else return YES;
}

- (IBAction)closeBtn:(id)sender {
    [self.linkView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML = \"\";"];
    [self.view bringSubviewToFront:self.webView];
    
}
@end


