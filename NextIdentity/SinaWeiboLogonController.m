//
//  SinaWeiboLogonController.m
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "SinaWeiboLogonController.h"

@implementation SinaWeiboLogonController

@synthesize delegate;

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"%@", response.userInfo);
    if(response.statusCode != WeiboSDKResponseStatusCodeSuccess)
        [self.delegate getLogonResult:NO Type:SINA_WEIBO Info:response.userInfo];
    else
    {
        [self updateLogonToken:response.userInfo];
        [self.delegate getLogonResult:YES Type:SINA_WEIBO Info:response.userInfo];
    }
}

- (void) startLogon
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ID.Sina.Wb"};
    [WeiboSDK sendRequest:request];
}

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.model.isAuthed == YES)
        return;
    [self.model addUserTokens:dict[@"access_token"] RefreshToken:@"" ExpireIn:dict[@"expires_in"] UserID:dict[@"uid"] UserNick:@""];
}

@end
