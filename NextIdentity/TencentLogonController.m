//
//  TencentLogonViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-2.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "TencentLogonController.h"
#import "AppDelegate.h"

#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentOAuthObject.h>

@interface TencentLogonController ()

@end

@implementation TencentLogonController

- (void) startLogon
{
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:@TENCENT_APPID andDelegate:self];
    NSArray* permissions = [NSArray arrayWithObjects:
                              kOPEN_PERMISSION_GET_USER_INFO,
                              kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                              kOPEN_PERMISSION_GET_INFO,
                              kOPEN_PERMISSION_GET_OTHER_INFO,
                              nil];
    [tencentOAuth authorize:permissions];
}

- (void)tencentDidLogin
{
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        NSDictionary* dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: tencentOAuth.accessToken, [NSString stringWithFormat:@"%ld", (long)tencentOAuth.expirationDate.timeIntervalSinceNow], tencentOAuth.openId, nil] forKeys:[NSArray arrayWithObjects: @"access_token", @"expires_in", @"user_id", nil]];
        [self updateLogonToken: dict];
        [self.delegate getLogonResult:YES Type:TENCENT Info:dict];
    }
    else
    {
        [self.delegate getLogonResult:NO Type:TENCENT Info:nil];
    }
    

}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.model.isAuthed == YES)
        return;
    self.model.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
    self.model.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
    self.model.dictModel[@"user_infos"][@"user_id"] = dict[@"user_id"];
    self.model.isAuthed = YES;
}

@end
