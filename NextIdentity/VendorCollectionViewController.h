//
//  VendorCollectionViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSIdentityModel.h"
#import "VendorLogonViewController.h"
#import "SinaWeiboLogonController.h"
#import "TencentLogonController.h"

@interface VendorCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, WBHttpRequestDelegate, VendorDelegate>
{
    SinaWeiboLogonController* sinaWeiboLogonController;
    TencentLogonController* tencentLogonController;
}

@property (assign, nonatomic) NSMutableArray* vendorList;
- (void) showDetailInfo:(VENDORTYPE) type withLogonToken:(NSDictionary*) dictToken;
- (void) showDoubanLogon;
- (void) showSinaWeiboLogon;
- (void) showTaobaoLogon;
- (void) showTencentLogon;
- (BOOL) handleSinaWeiboUrl: (NSURL*)url;
- (BOOL) handleTencentUrl: (NSURL*)url;
@end
