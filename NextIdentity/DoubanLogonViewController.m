//
//  DoubanLogonViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "DoubanLogonViewController.h"

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
    self.webView.delegate = self;
    [self.webView loadRequest:urlRequest];
    return;
}

- (void) getAuthResponse: (NSString*)code
{
    if([code hasPrefix:@"code="] ==YES)
    {
        NSString* auth_code = [code substringFromIndex:[code rangeOfString:@"="].location+1];
        URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@"https://www.douban.com/service/auth2/token" Body:[NSString stringWithFormat:@"client_id=%s&client_secret=%s&redirect_uri=http://step.2&grant_type=authorization_code&code=%@", DOUBAN_APIKEY, DOUBAN_APISECRET, auth_code] Topic:TOPIC_GET_ACCESS_TOKEN];
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) getResponseResult:(BOOL)isValid Result:(NSString *)result Topic:(NSInteger)topic
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(isValid == NO)
    {
        [self.delegate getLogonResult:NO Type:self.netType Info:nil];
    }
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    [self updateLogonToken:dict];
    [self.delegate getLogonResult:YES Type: self.netType Info: dict];
}

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.model.isAuthed == YES)
        return;
    self.model.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
    self.model.dictModel[@"logon_tokens"][@"refresh_token"] = dict[@"refresh_token"];
    self.model.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
    self.model.dictModel[@"user_infos"][@"user_id"] = dict[@"douban_user_id"];
    self.model.dictModel[@"user_infos"][@"user_nick"] = dict[@"douban_user_name"];
    self.model.isAuthed = YES;
}


@end
