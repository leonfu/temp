//
//  NSSinaWeiboIdentityModel.m
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSSinaWeiboIdentityModel.h"

#define TOPIC_GET_USER_INFO 0

#define MAX_TOPIC_COUNT 1

@implementation NSSinaWeiboIdentityModel

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.isAuthed == YES)
    {
        [self getResponseResult:YES Result:self.dictModel[@"user_infos"][@"user_id"] Topic:TOPIC_GET_USER_INFO];
        return;
    }
    self.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
    self.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
    self.dictModel[@"user_infos"][@"user_id"] = dict[@"uid"];
    self.isAuthed = YES;
    [self getResponseResult:YES Result:self.dictModel[@"user_infos"][@"user_id"] Topic:TOPIC_GET_USER_INFO];
}

- (void)getResponseResult:(BOOL)isValid Result:(NSString *)result Topic:(NSInteger)topic
{
    NSLog(@"%@", result);
    curr_topic_count ++;
    if(topic == TOPIC_GET_USER_INFO)
    {
        self.dictModel[@"user_infos"][@"user_profile"] = result;
    }
    
    if(curr_topic_count == MAX_TOPIC_COUNT)
    {
        [self.delegate modelComplete:YES Type:SINA_WEIBO];
        curr_topic_count = 0;
    }
}

@end
