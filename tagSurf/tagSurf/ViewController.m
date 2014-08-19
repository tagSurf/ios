//
//  ViewController.m
//  tagSurf
//
//  Created by Kieran Farrar on 6/19/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [[NSURL alloc] initWithString:@"http://beta.tagsurf.co/share/trending/0"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
