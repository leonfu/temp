//
//  NSDoubanIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSDoubanIdentityModel.h"

#define TOPIC_GET_USER_INFO 1
#define TOPIC_GET_USER_BOOK 2

#define MAX_TOPIC_COUNT 2

@implementation NSDoubanIdentityModel

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.isAuthed == NO)
    {
        self.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
        self.dictModel[@"logon_tokens"][@"refresh_token"] = dict[@"refresh_token"];
        self.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
        self.dictModel[@"user_infos"][@"user_id"] = dict[@"douban_user_id"];
        self.dictModel[@"user_infos"][@"user_nick"] = dict[@"douban_user_name"];
        self.isAuthed = YES;
    }
    [self.delegate modelComplete:YES Type:DOUBAN];
}

- (void) buildUserInfo
{
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringGET:@"https://api.douban.com/v2/user/~me" Headers:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"Bearer %@", self.dictModel[@"logon_tokens"][@"token"]], @"Authorization", nil] Topic:TOPIC_GET_USER_INFO];
    handler.delegate = self;
    [handler start];
}

- (void) buildUserFavoriteBooks
{
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringGET:[NSString stringWithFormat:@"https://api.douban.com/v2/book/user/%@/collections", self.dictModel[@"user_infos"][@"user_nick"]] Headers: nil Topic:TOPIC_GET_USER_BOOK];
    handler.delegate = self;
    [handler start];
}

- (void)getResponseResult:(BOOL)isValid Result:(NSString *)result Topic:(NSInteger)topic
{
    NSLog(@"%@", result);
    curr_topic_count ++;
    if(topic == TOPIC_GET_USER_INFO)
    {
        self.dictModel[@"user_infos"][@"user_profile"] = result;
    }
    else if(topic == TOPIC_GET_USER_BOOK)
    {
        [self addNewKey:@"user_favorites" SubKeys:[NSArray arrayWithObject:@"books"]];
        self.dictModel[@"user_favorites"][@"books"] = result;
    }
    
    if(curr_topic_count == MAX_TOPIC_COUNT)
    {
        [self.delegate modelComplete:YES Type:DOUBAN];
        curr_topic_count = 0;
    }
}

@end
