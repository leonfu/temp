//
//  NSSinaWeiboIdentityModel.m
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSSinaWeiboIdentityModel.h"

@implementation NSSinaWeiboIdentityModel

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.isAuthed == NO)
    {
        self.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
        self.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
        self.dictModel[@"user_infos"][@"user_id"] = dict[@"uid"];
        self.isAuthed = YES;
    }
    [self.delegate modelComplete:YES Type:SINA_WEIBO];
}

@end
