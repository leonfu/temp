//
//  VendorCollectionViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAssetModel.h"
#import "VendorLogonViewController.h"
#import "SinaWeiboLogonController.h"
#import "TencentLogonController.h"

@interface VendorCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, WBHttpRequestDelegate, VendorDelegate>
{
    SinaWeiboLogonController* sinaWeiboLogonController;
    TencentLogonController* tencentLogonController;
    VENDOR_TYPE vendorType;
}

@property (assign, nonatomic) NSMutableArray* vendorList;
- (void) showDetailInfo:(VENDOR_TYPE) type withLogonToken:(NSDictionary*) dictToken;
- (void) showDoubanLogon;
- (void) showSinaWeiboLogon;
- (void) showTaobaoLogon;
- (void) showTencentLogon;
- (void) showLinkedInLogon;
- (BOOL) handleSinaWeiboUrl: (NSURL*)url;
- (BOOL) handleTencentUrl: (NSURL*)url;
@end
