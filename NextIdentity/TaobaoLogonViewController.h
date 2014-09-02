//
//  TaobaoLogonViewController.h
//  NextIdentity
//
//  Created by Leon Fu on 9/2/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "LogonViewController.h"
#import "URLRequestHandler.h"

@interface TaobaoLogonViewController : LogonViewController<UIWebViewDelegate, RequestDelegate>

- (void) showLogonView;

@end
