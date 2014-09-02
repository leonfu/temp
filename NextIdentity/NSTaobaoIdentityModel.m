//
//  NSTaobaoIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/2/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSTaobaoIdentityModel.h"

@implementation NSTaobaoIdentityModel

- (void) updateLogonToken: (NSDictionary*) dict
{
    if(self.isAuthed == NO)
    {
        self.dictModel[@"logon_tokens"][@"token"] = dict[@"access_token"];
        self.dictModel[@"logon_tokens"][@"expire_time"] = dict[@"expires_in"];
        self.dictModel[@"logon_tokens"][@"refresh_token"] = dict[@"refresh_token"];
        self.dictModel[@"user_infos"][@"user_id"] = dict[@"taobao_user_id"];
        self.dictModel[@"user_infos"][@"user_nick"] = dict[@"taobao_user_nick"];
        self.isAuthed = YES;
    }
    [self.delegate modelComplete:YES Type:TAOBAO];
}
@end
