//
//  LinkedInLogonViewController.m
//  DigitalAssets
//
//  Created by Leon Fu on 9/9/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "LinkedInLogonViewController.h"

@interface LinkedInLogonViewController ()

@end

@implementation LinkedInLogonViewController

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
    [self showLogonView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showLogonView
{
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=%s&scope=r_fullprofile%%20r_contactinfo%%20r_emailaddress&state=%s&redirect_uri=http://step.1", LINKEDIN_APPKEY, LINKEDIN_APPKEY]]];
    self.webView.delegate = self;
    [self.webView loadRequest:urlRequest];
    return;
}

- (void) getAuthResponse: (NSString*)code
{
    NSString* auth_code = [self parseURLQuery:code forKey:@"code"];
    if(auth_code)
    {
        URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@"https://www.linkedin.com/uas/oauth2/accessToken" Body:[NSString stringWithFormat:@"grant_type=authorization_code&code=%@&redirect_uri=http://step.1&client_id=%s&client_secret=%s", auth_code, LINKEDIN_APPKEY, LINKEDIN_APPSECRET] Topic:TOPIC_GET_ACCESS_TOKEN];
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
    [self.model addUserTokens:dict[@"access_token"] RefreshToken:@"" ExpireIn: dict[@"expires_in"] UserID:@"" UserNick:@""];
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

@end
