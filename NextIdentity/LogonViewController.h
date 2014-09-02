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

@protocol LogonDelegate

- (void) getLogonResult: (BOOL)result Type: (NETTYPE)type Info: (NSDictionary*) info;

@end

@interface LogonViewController : UIViewController
{
    NETTYPE netType;
    UIWebView* webView;
}
@property NETTYPE netType;
@property (nonatomic, assign) id <LogonDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView* webView;

- (void) closeView;

@end
