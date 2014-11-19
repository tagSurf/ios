//
//  ViewController.h
//  tagSurf
//
//  Created by Kieran Farrar on 6/19/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URXSearch/URXSearchResult.h>


@interface ViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
