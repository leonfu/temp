//
//  TencentLogonViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-2.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "LogonViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface TencentLogonController : NSObject<TencentSessionDelegate>
{
    TencentOAuth* tencentOAuth;
}
@property (nonatomic, assign) id <LogonDelegate> delegate;
@property (nonatomic, assign) NSIdentityModel* model;

- (void) startLogon;

@end
