//
//  TaobaoLogonViewController.m
//  NextIdentity
//
//  Created by Leon Fu on 9/2/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "TaobaoLogonViewController.h"

@interface TaobaoLogonViewController ()

@end

@implementation TaobaoLogonViewController

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
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://oauth.m.taobao.com/authorize?response_type=code&client_id=%s&redirect_uri=http://step.1&state=%d&scope=item,promotion,item,usergrade", TAOBAO_APIKEY, TAOBAO]]];
    self.webView.delegate = self;
    [self.webView loadRequest:urlRequest];
    return;
}

- (void) getAuthResponse: (NSString*)code
{
    if([code hasPrefix:@"code="] == YES)
    {
        NSString* auth_code = [code substringWithRange:NSMakeRange(5, [code rangeOfString:@"&"].location-5)];
        URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@"https://oauth.taobao.com/token" Body:[NSString stringWithFormat:@"grant_type=authorization_code&code=%@&redirect_uri=http://step.1&client_id=%s&client_secret=%s", auth_code, TAOBAO_APIKEY, TAOBAO_APISECRET] Topic:TOPIC_GET_ACCESS_TOKEN];
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
    [self.model addUserTokens:dict[@"access_token"] RefreshToken:dict[@"refresh_token"] ExpireIn:dict[@"expires_in"] UserID:dict[@"taobao_user_id"] UserNick:dict[@"taobao_user_nick"]];
}

@end
