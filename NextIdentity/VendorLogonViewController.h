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
#import "NSAssetModel.h"

@protocol VendorLogonDelegate

- (void) getLogonResult: (BOOL)result Type: (VENDOR_TYPE)type Info: (NSDictionary*) info;

@end

@interface VendorLogonViewController : UIViewController
{
    VENDOR_TYPE netType;
    UIWebView* webView;
}
@property (nonatomic, assign) NSAssetModel* model;
@property VENDOR_TYPE netType;
@property (nonatomic, assign) id <VendorLogonDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView* webView;

- (NSString*)parseURLQuery:(NSString*)query forKey:(NSString*)key;

- (void) closeView;

@end
