//
//  LinkedInLogonViewController.h
//  DigitalAssets
//
//  Created by Leon Fu on 9/9/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "VendorLogonViewController.h"

@interface LinkedInLogonViewController : VendorLogonViewController<UIWebViewDelegate, RequestDelegate>


- (void) showLogonView;

@end
