//
//  DoubanLogonViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "LogonViewController.h"

@interface DoubanLogonViewController : LogonViewController<UIWebViewDelegate, RequestDelegate>


- (void) showLogonView;

@end
