//
//  AboutServiceController.m
//  Travel Maker
//
//  Created by developer on 1/5/16.
//  Copyright © 2016 developer. All rights reserved.
//

#import "AboutServiceController.h"

@implementation AboutServiceController

@synthesize webService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"htm"];
//    NSError *error = nil;
//    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"error: %@", error);
//    [webService loadHTMLString:htmlString baseURL:nil];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"about" withExtension:@"htm"];
    [webService loadRequest:[NSURLRequest requestWithURL:url]];
    [webService setBackgroundColor:[UIColor whiteColor]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction
- (void)clickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = theWebView.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    theWebView.scrollView.zoomScale = rw;

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
