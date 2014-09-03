//
//  AppDelegate.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

typedef enum {DOUBAN=0, SINA_WEIBO, TAOBAO, TENCENT} NETTYPE;

#define TOPIC_GET_ACCESS_TOKEN 0

#define SINAWEIBO_APIKEY @"3147952809"

#define DOUBAN_APIKEY "09c92b8c7d3f9ac11d5b82a577bed043"
#define DOUBAN_APISECRET "b61ff05818339a08"

#define TAOBAO_APIKEY "23013352"
#define TAOBAO_APISECRET "e9a0d229aea64b2d5762a5cb3b07ec82"

#define TENCENT_APPID "1102367924"
#define TENCENT_APPKEY "R1s5GDpiDcK4j5D8"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
