//
//  DoubanLogonViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "DoubanLogonViewController.h"

#define DOUBAN_APIKEY "09c92b8c7d3f9ac11d5b82a577bed043"
#define DOUBAN_APISECRET "b61ff05818339a08"

@interface DoubanLogonViewController ()

@end

@implementation DoubanLogonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    [self showLogonView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) showLogonView
{
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%s&redirect_uri=http://step.1&response_type=code&scope=shuo_basic_r,shuo_basic_w,douban_basic_common", DOUBAN_APIKEY]]];
    [self.webView loadRequest:urlRequest];
    return;
}

- (void) getAuthResponse: (NSString*)code
{
    if([code hasPrefix:@"code="] ==YES)
    {
        NSString* auth_code = [code substringFromIndex:[code rangeOfString:@"="].location+1];
        URLRquestHandler* handler = [[URLRquestHandler alloc] initWithURLString:@"https://www.douban.com/service/auth2/token" Body:[NSString stringWithFormat:@"client_id=%s&client_secret=%s&redirect_uri=http://step.2&grant_type=authorization_code&code=%@", DOUBAN_APIKEY, DOUBAN_APISECRET, auth_code]];
        handler.delegate = self;
        [handler start];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate getLogonResult:NO Type:self.netType Info:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.host compare: @"step.1"] == NSOrderedSame)
    {
        [self getAuthResponse: request.URL.query];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
                                        
- (void) getResponseResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(result == nil)
    {
        [self.delegate getLogonResult:NO Type:self.netType Info:nil];
    }
    [self.delegate getLogonResult:YES Type: self.netType Info: result];
}

@end