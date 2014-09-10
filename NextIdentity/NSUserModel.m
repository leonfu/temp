//
//  NSUserModel.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSUserModel.h"

@implementation NSUserModel

@synthesize isLogon, phone, email, sex, nick;

static NSUserModel *_sharedInstance;

+ (NSUserModel*) sharedInstance
{
    @synchronized(self)
    {
        if (!_sharedInstance)
        {
            _sharedInstance = [[NSUserModel alloc] init];
        }
    }
    
    return _sharedInstance;
}

- (id) init
{
    if(self = [super init])
    {
        self.isLogon = NO;
        fillStatus = 0;
    }
    return self;
}

- (void) fillUserProfile: (NSDictionary*) dict
{
    dictModel = [dict mutableCopy];
    fillStatus = 2;
}

- (void) fillUserBrief: (NSDictionary*) dict
{
    dictModel = [dict mutableCopy];
    fillStatus = 1;
}

- (void) setIsLogon: (BOOL) value
{
    isLogon = value;
    if(value == NO)
        [dictModel removeAllObjects];
}

- (NSString*) phone
{
    if(fillStatus < 1)
        return @"";
    return dictModel[@"mobile"] == nil ? @"": dictModel[@"mobile"];
}

- (NSString*) email
{
    if(fillStatus < 2)
        return @"";
    return dictModel[@"profile"][@"email"] == nil ? @"": dictModel[@"profile"][@"email"];
}

- (NSString*) sex
{
    if(fillStatus < 2)
        return @"";
    return ((NSString*)dictModel[@"profile"][@"sex"]).intValue == 0 ? @"男" : @"女" ;
}

- (NSString*) nick
{
    if(fillStatus < 1)
        return @"";
    return dictModel[@"username"] == nil ? @"": dictModel[@"username"];
}

@end
