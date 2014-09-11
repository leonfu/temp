//
//  AppDelegate.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboSDK.h"
#import "Common.h"

@protocol VendorDelegate

-(BOOL) openType:(VENDOR_TYPE)type URL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (assign, nonatomic) id<VendorDelegate> delegate;
@property (strong, nonatomic) UIWindow *window;

@end
