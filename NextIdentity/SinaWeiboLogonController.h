//
//  SinaWeiboLogonController.h
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "VendorLogonViewController.h"

@interface SinaWeiboLogonController : NSObject<WeiboSDKDelegate>

@property (nonatomic, assign) id <VendorLogonDelegate> delegate;
@property (nonatomic, assign) NSAssetModel* model;

- (void) startLogon;

@end
