//
//  SinaWeiboLogonController.h
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "LogonViewController.h"

@interface SinaWeiboLogonController : NSObject<WeiboSDKDelegate>

@property (nonatomic, assign) id <LogonDelegate> delegate;
- (void) startLogon;

@end
