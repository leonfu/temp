//
//  AppDelegate.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

typedef enum {DOUBAN=0, SINA_WEIBO} NETTYPE;

#define TOPIC_GET_ACCESS_TOKEN 0

#define SINAWEIBO_APIKEY @"3147952809"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
