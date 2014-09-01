//
//  ViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogonViewController.h"
#import "NSIdentityModel.h"
#import "SinaWeiboLogonController.h"

@interface ViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, LogonDelegate, WBHttpRequestDelegate>

@property(strong, nonatomic) NSArray* IdentityList;
@property(strong, nonatomic) SinaWeiboLogonController* sinaWeiboLogonController;

- (void) showDetailInfo:(NETTYPE) type withLogonToken:(NSDictionary*) dictToken;
- (void) showDoubanLogon;
- (void) showSinaWeiboLogon;
- (BOOL) handleSinaWeiboUrl: (NSURL*)url;

@end
