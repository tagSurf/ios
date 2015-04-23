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
#import "AppDelegate.h"
#import <sys/utsname.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

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
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FBSDKProfileDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //do whatever you want
        
    }];
    
    NSURL *url;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.targetUrl) {
      url = [NSURL URLWithString:delegate.targetUrl];
    }
    else {
      url = [NSURL URLWithString:@"http://beta.tagsurf.co/share/funny/0"];
    }
    delegate.targetUrl = nil;
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.targetUrl) {
        NSURL *url = [NSURL URLWithString:delegate.targetUrl];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
    delegate.targetUrl = nil;
    
}

- (void)loadURL:(NSString *)urlToLoad {
    NSURL *url = [NSURL URLWithString:urlToLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)loadCard:(NSString *)tag cardID:(NSString *)cardID {
    NSArray *urlComponents = [[NSArray alloc] initWithObjects:@"http://beta.tagsurf.co/share", tag, cardID, nil];
    NSString *urlString = [urlComponents componentsJoinedByString:@"/"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - UIWebViewDelegate
 -(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestedURL = request.URL.absoluteString;


    if(navigationType == 0 || (navigationType == 5 && !([requestedURL rangeOfString:@"push" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch].location == NSNotFound))) {
        if(!([requestedURL rangeOfString:@"nativeShare" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            
            NSString *shareLink = [[requestedURL componentsSeparatedByString:@"//"] objectAtIndex:2];
            NSString *tag = [[shareLink componentsSeparatedByString:@"/"] objectAtIndex:2];
            
            NSString *message1 = @"OMG this is so #";
            NSString *message = [message1 stringByAppendingString:tag];
            NSURL *link = [NSURL URLWithString:[@"http://" stringByAppendingString:shareLink]];
            
            NSArray *objectsToShare = @[message, link];
            
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                           UIActivityTypePrint,
                                           UIActivityTypeAssignToContact,
                                           UIActivityTypeSaveToCameraRoll,
                                           UIActivityTypeAddToReadingList,
                                           UIActivityTypePostToFlickr,
                                           UIActivityTypePostToVimeo];
            
            activityVC.excludedActivityTypes = excludeActivities;
            
            [self presentViewController:activityVC animated:YES completion:nil];
            
            return NO;
        }
        else if(!([requestedURL rangeOfString:@"tagsurf" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
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
            closeBtn.frame = CGRectMake((self.view.frame.size.width - 55)/2, (self.view.frame.size.height - 52), 55, 32);
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
    else if(!([requestedURL rangeOfString:@"auth" options:NSCaseInsensitiveSearch].location == NSNotFound) && !([requestedURL rangeOfString:@"facebook" options:NSCaseInsensitiveSearch].location == NSNotFound)) {

        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
            } else if (result.isCancelled) {
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    // Do work
                    [self.webView stopLoading];
                    if ([FBSDKAccessToken currentAccessToken]) {
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                             if (!error) {
                                 
                                 NSString *first_name = [result objectForKey:@"first_name"];
                                 NSString *last_name = [result objectForKey:@"last_name"];
                                 NSString *email = [result objectForKey:@"email"];
                                 NSNumber *fbID = [result objectForKey:@"id"];
                                 NSString *locale = [result objectForKey:@"locale"];
                                 NSString *gender = [result objectForKey:@"gender"];
                                 NSString *token = [FBSDKAccessToken currentAccessToken].tokenString;
                                 
                                 NSLog(@"location =%@", locale);
                                 
                                 NSString *post = [NSString stringWithFormat:@"uid=%@&email=%@&first_name=%@&last_name=%@&facebook_auth_token=%@&gender=%@&location=%@", fbID, email, first_name, last_name, token,  gender, locale];
                                 
                                 NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                                 
                                 NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
                                 
                                 NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
                                 
                                 [postRequest setURL:[NSURL URLWithString:@"http://beta.tagsurf.co/authentication/from-native"]];
                                 [postRequest setHTTPMethod:@"POST"];
                                 [postRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
                                 [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                                 [postRequest setHTTPBody:postData];
                                 
                                 [self.webView loadRequest:postRequest];
                                 
                             }
                         }];
                        
                    }

                }
            }
        }];
        return NO;
    }
    else return YES;
}

- (IBAction)closeBtn:(id)sender {
    [self.linkView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML = \"\";"];
    [self.view bringSubviewToFront:self.webView];
    
}
@end


