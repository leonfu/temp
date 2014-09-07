//
//  LogonViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "URLRequestHandler.h"
#import "NSIdentityModel.h"

@protocol VendorLogonDelegate

- (void) getLogonResult: (BOOL)result Type: (VENDORTYPE)type Info: (NSDictionary*) info;

@end

@interface VendorLogonViewController : UIViewController
{
    VENDORTYPE netType;
    UIWebView* webView;
}
@property (nonatomic, assign) NSIdentityModel* model;
@property VENDORTYPE netType;
@property (nonatomic, assign) id <VendorLogonDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView* webView;

- (void) closeView;

@end
