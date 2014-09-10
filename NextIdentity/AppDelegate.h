//
//  AppDelegate.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboSDK.h"
#import "URLRequestHandler.h"
#import "Utility.h"

typedef enum {DOUBAN=0, TENCENT, SINA_WEIBO, TAOBAO, LINKEDIN, WECHAT, ALLTYPE} VENDOR_TYPE;

#define URL_SERVER_PATH "https://api.shucaibao/"

#define SINAWEIBO_APIKEY "3147952809"

#define DOUBAN_APIKEY "09c92b8c7d3f9ac11d5b82a577bed043"
#define DOUBAN_APISECRET "b61ff05818339a08"

#define TAOBAO_APIKEY "23013352"
#define TAOBAO_APISECRET "e9a0d229aea64b2d5762a5cb3b07ec82"

#define TENCENT_APPID "1102367924"
#define TENCENT_APPKEY "R1s5GDpiDcK4j5D8"

#define LINKEDIN_APPKEY "75bhl680xuha54"
#define LINKEDIN_APPSECRET "fOc9A1ObgUYNxLdf"
//d9c43dfb-e8a1-4f62-9716-a4226755c901 / ee018e62-fb08-45d6-ad8f-794077a70f47   

@protocol VendorDelegate

-(BOOL) openType:(VENDOR_TYPE)type URL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (assign, nonatomic) id<VendorDelegate> delegate;
@property (strong, nonatomic) UIWindow *window;

@end
