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
#import "TencentLogonController.h"

@interface ViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, LogonDelegate, WBHttpRequestDelegate>
{
    SinaWeiboLogonController* sinaWeiboLogonController;
    TencentLogonController* tencentLogonController;
}
@property(strong, nonatomic) NSArray* IdentityList;

- (void) showDetailInfo:(NETTYPE) type withLogonToken:(NSDictionary*) dictToken;
- (void) showDoubanLogon;
- (void) showSinaWeiboLogon;
- (void) showTaobaoLogon;
- (void) showTencentLogon;
- (BOOL) handleSinaWeiboUrl: (NSURL*)url;
- (BOOL) handleTencentUrl: (NSURL*)url;

@end
